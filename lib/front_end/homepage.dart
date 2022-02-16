import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sendlink_application/back_end/Timetable.dart';
import 'package:sendlink_application/back_end/storage.dart';
import 'package:sendlink_application/back_end/subject.dart';
import 'colors.dart' as color;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // !Time Variable
  late DateTime time_with_no_format, ampm, day_month_no_format;
  String timenow = "", ampm_now = "", day_month = "";
  late Timer _timer;
  late int hourCheckInt;
  late int minuteCheckInt;
  late String hourCheck;
  late String minuteCheck;
  String dayInWeek = "";

  // !Subject Variable
  List<Subject> subject = [];
  List<Subject> subject_during = [];
  List<Subject> subject_upnext = [];
  List<Subject> subject_done = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    runningClock();
  }

  void testingAddTimeTable() {
    TimeTable.addSubject(Subject.addSubject(
        'Circuit Signal System', 'www.english.com', 'onsite', [
      [4, 7, 30, 19, 30],
      [2, 13, 0, 16, 00]
    ]));

    TimeTable.addSubject(
        Subject.addSubject('English', 'www.english.com', 'onsite', [
      [3, 7, 30, 18, 30],
      [1, 13, 0, 17, 30]
    ]));

    TimeTable.addSubject(Subject.addSubject(
        'Digital Logic Design', 'www.english.com', 'onsite', [
      [3, 7, 30, 19, 30],
      [1, 13, 0, 16, 00]
    ]));
  }

  void runningClock() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        time_with_no_format = DateTime.now();
        ampm = DateTime.now();
        day_month_no_format = DateTime.now();
        String datetime1 = DateFormat("HH:mm").format(time_with_no_format);
        String datetime2 = DateFormat("a").format(ampm);
        String datetime3 =
            DateFormat("EEEEEE, MMM dd").format(day_month_no_format);
        String datetime4 = DateFormat("EEEEEE").format(day_month_no_format);
        timenow = "${datetime1}";
        ampm_now = "${datetime2}";
        day_month = "${datetime3}";
        dayInWeek = "${datetime4}";
        hourCheck = DateFormat("HH").format(time_with_no_format);
        minuteCheck = DateFormat("mm").format(time_with_no_format);
        hourCheckInt = int.parse(hourCheck);
        minuteCheckInt = int.parse(minuteCheck);
      });
      testingAddTimeTable();
      openData();
      print(subject_during[0]);
    });
  }

  void openData() {
    subject = TimeTable.listSubject;
    addData();
    for (var i = 0; i < subject.length; i++) {
      for (var i = 0; i < subject[i].allTimeLearn.length; i++) {}
    }
  }

  Future<int> dayStringToDayInt(String dayString) async {
    if (dayString == 'Sunday') {
      return 1;
    } else if (dayString == 'Monday') {
      return 2;
    } else if (dayString == 'Tuesday') {
      return 3;
    } else if (dayString == 'Wednesday') {
      return 4;
    } else if (dayString == 'Thursday') {
      return 5;
    } else if (dayString == 'Friday') {
      return 6;
    } else if (dayString == 'Saturday') {
      return 7;
    } else {
      return -1;
    }
  }

  void addData() {
    for (var i = 0; i < TimeTable.listSubject.length; i++) {
      for (var j = 0; j < TimeTable.listSubject[i].allTimeLearn.length; j++) {
        //done
        if (hourCheckInt > timeCheck(i, j, 3) &&
            minuteCheckInt > timeCheck(i, j, 4) &&
            dayStringToDayInt(dayInWeek) == timeCheck(i, j, 0)) {
          subject_done.add(TimeTable.listSubject[i]);
        } else if (hourCheckInt < timeCheck(i, j, 1) &&
            minuteCheckInt < timeCheck(i, j, 2) &&
            dayStringToDayInt(dayInWeek) == timeCheck(i, j, 0)) {
          subject_upnext.add(TimeTable.listSubject[i]);
        } else if (hourCheckInt < timeCheck(i, j, 1) &&
            minuteCheckInt < timeCheck(i, j, 2) &&
            dayStringToDayInt(dayInWeek) == timeCheck(i, j, 0)) {
          subject_during.add(TimeTable.listSubject[i]);
        }
      }
    }
  }

  int timeCheck(int i, int j, int positionTime) {
    return TimeTable.listSubject[i].allTimeLearn[j][positionTime];
  }

  /* Future<File> _incrementCounter() {
    setState(() {
      subject = TimeTable.timetable.toString();
    });

    // Write the variable as a string to the file.
    return Storage.writeSubject(subject);
  } */

  //start 0
  //end 1
  String getTimeClass(int i, int j, int when) {
    int hour = 1;
    int minute = 2;
    String tempHour;
    String tempMinute;
    if (when == 0) {
      int hour = 1;
      int minute = 2;
    } else if (when == 1) {
      int hour = 3;
      int minute = 4;
    }
    if (subject_during[i].allTimeLearn[j][hour] < 10) {
      tempHour = "0" + subject_during[i].allTimeLearn[j][hour].toString();
    } else {
      tempHour = subject_during[i].allTimeLearn[j][hour].toString();
    }
    if (subject_during[i].allTimeLearn[j][minute] < 10) {
      tempMinute = "0" + subject_during[i].allTimeLearn[j][minute].toString();
    } else {
      tempMinute = subject_during[i].allTimeLearn[j][minute].toString();
    }
    if (subject_during[i].allTimeLearn[j][hour] >= 12 && when == 1) {
      return tempHour + ":" + tempMinute + " PM ";
    } else if (subject_during[i].allTimeLearn[j][hour] < 12 && when == 1) {
      return tempHour + ":" + tempMinute + " AM ";
    } else {
      return tempHour + ":" + tempMinute;
    }
  }

  //widget for add subject in real time
  List<Widget> getDurringClass() {
    List<Widget> data = [];
    for (var i = 0; i < subject_during.length; i++) {
      data.add(Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: 50,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: color.AppColor.box_class,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 5,
                        color: Colors.grey.withOpacity(0.8))
                  ]),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            subject_during[i].name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            getTimeClass(i, 0, 0) +
                                " - " +
                                getTimeClass(i, 0, 1),
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          )
                        ],
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                        color: color.AppColor.offline,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 5,
                              color: Colors.grey.withOpacity(1))
                        ]),
                    child: Center(
                      child: Text(
                        "Join",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ));
    }
    return data;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
          child: Column(children: [
            Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        color.AppColor.Gradient1,
                        color.AppColor.Gradient1.withOpacity(0.8),
                        color.AppColor.Gradient2.withOpacity(0.8),
                        color.AppColor.Gradient2,
                        //add more colors for gradient
                      ],
                      begin: Alignment.topRight, //begin of the gradient color
                      end: Alignment.bottomLeft, //end of the gradient color
                      stops: [0, 0.1, 0.9, 1] //stops for individual color
                      //set the stops number equal to numbers of color
                      ),
                  borderRadius:
                      BorderRadius.circular(30), //border corner radius
                ),
                alignment: Alignment.center,
                child: Column(children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: IconButton(
                          icon: Icon(
                            IconData(0xf694, fontFamily: 'MaterialIcons'),
                          ),
                          iconSize: 20,
                          color: Colors.white,
                          splashColor: Colors.white.withOpacity(0.2),
                          onPressed: () {},
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Icon(
                        IconData(0xf0027, fontFamily: 'MaterialIcons'),
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        IconData(0xf5fe, fontFamily: 'MaterialIcons'),
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 65,
                      ),
                      Text(
                        timenow,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 80,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 6.0),
                              blurRadius: 10.0,
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            ampm_now,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(1.0, 6.0),
                                  blurRadius: 10.0,
                                  color: Colors.black.withOpacity(0.2),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 13,
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 70,
                      ),
                      Text(day_month,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, 6.0),
                                blurRadius: 10.0,
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  )
                ])),
            /**     
             * Add Class Schedule 
             * *    When you find a day's class, create a
             * * Container to add subjects to it. 
             * ! 4 case
             * TODO: case 1 no class today
             * TODO: case 2 have class done
             * TODO: case 2 have class during
             * TODO: case 2 have class up next
             *  
             * 
             * 
             * 
            */
            Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color.AppColor.WidgetBackground.withOpacity(0.5),
                  borderRadius:
                      BorderRadius.circular(20), //border corner radius
                ),
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Finished",
                            style: TextStyle(
                              color: color.AppColor.NameWidget,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(1.0, 3.0),
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      /* Container(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              height: 50,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: color.AppColor.box_class,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 5),
                                        blurRadius: 5,
                                        color: Colors.grey.withOpacity(0.8))
                                  ]),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            fileContent.toString() +
                                                "teeeeeeeeeeee",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            "9:00 - 10:30 AM",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    width: 50,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: color.AppColor.offline,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 5),
                                              blurRadius: 5,
                                              color: Colors.grey.withOpacity(1))
                                        ]),
                                    child: Center(
                                      child: Text(
                                        "Join",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ), */
                      Column(
                        children: getDurringClass(),
                      )
                    ],
                  ),
                )),
            Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color.AppColor.WidgetBackground.withOpacity(0.5),
                  borderRadius:
                      BorderRadius.circular(20), //border corner radius
                ),
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "During",
                            style: TextStyle(
                              color: color.AppColor.NameWidget,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(1.0, 3.0),
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              height: 50,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: color.AppColor.box_class,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 5),
                                        blurRadius: 5,
                                        color: Colors.grey.withOpacity(0.8))
                                  ]),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Digital Logic Design",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            "9:00 - 10:30 AM",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    width: 50,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              color.AppColor.Gradient3,
                                              color.AppColor.Gradient3
                                                  .withOpacity(0.8),
                                              color.AppColor.Gradient4
                                                  .withOpacity(0.8),
                                              color.AppColor.Gradient4,
                                              //add more colors for gradient
                                            ],
                                            begin: Alignment
                                                .topRight, //begin of the gradient color
                                            end: Alignment
                                                .bottomLeft, //end of the gradient color
                                            stops: [
                                              0,
                                              0.1,
                                              0.9,
                                              1
                                            ] //stops for individual color
                                            //set the stops number equal to numbers of color
                                            ),
                                        color: color.AppColor.offline,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 5),
                                              blurRadius: 5,
                                              color:
                                                  Colors.grey.withOpacity(1)),
                                        ]),
                                    child: Center(
                                      child: Text(
                                        "Join",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            Container(
              margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: color.AppColor.WidgetBackground.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20), //border corner radius
              ),
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Up Next",
                          style: TextStyle(
                            color: color.AppColor.NameWidget,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, 3.0),
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            height: 50,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: color.AppColor.box_class,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 5),
                                      blurRadius: 5,
                                      color: Colors.grey.withOpacity(0.8))
                                ]),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Digital Logic Design",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "9:00 - 10:30 AM",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Expanded(child: Container()),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  width: 50,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            color.AppColor.Gradient1,
                                            color.AppColor.Gradient1
                                                .withOpacity(0.8),
                                            color.AppColor.Gradient2
                                                .withOpacity(0.8),
                                            color.AppColor.Gradient2,
                                            //add more colors for gradient
                                          ],
                                          begin: Alignment
                                              .topRight, //begin of the gradient color
                                          end: Alignment
                                              .bottomLeft, //end of the gradient color
                                          stops: [
                                            0,
                                            0.1,
                                            0.9,
                                            1
                                          ] //stops for individual color
                                          //set the stops number equal to numbers of color
                                          ),
                                      color: color.AppColor.offline,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 5),
                                            blurRadius: 5,
                                            color: Colors.grey.withOpacity(1)),
                                      ]),
                                  child: Center(
                                    child: Text(
                                      "Join",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: color.AppColor.WidgetBackground.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20), //border corner radius
              ),
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "List to do",
                          style: TextStyle(
                            color: color.AppColor.NameWidget,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, 3.0),
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: color.AppColor.box_class,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 5),
                                      blurRadius: 5,
                                      color: Colors.grey.withOpacity(0.8))
                                ]),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      IconData(
                                        0xe047,
                                        fontFamily: 'MaterialIcons',
                                      ),
                                      size: 24,
                                      color: color.AppColor.NameWidget,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 5, 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Add work",
                                            style: TextStyle(
                                                color:
                                                    color.AppColor.NameWidget),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Divider(
                                    //height: 20,
                                    thickness: 1,
                                    color: color.AppColor.NameWidget),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Icon(
                                      IconData(0xe158,
                                          fontFamily: 'MaterialIcons'),
                                      color: color.AppColor.Gradient1,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Differential Equation",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "work",
                                            style: TextStyle(
                                                fontSize: 10, height: 0.7),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                    //height: 20,
                                    thickness: 1,
                                    color: color.AppColor.NameWidget),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Icon(
                                      IconData(0xe098,
                                          fontFamily: 'MaterialIcons'),
                                      color: color.AppColor.Gradient1,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Done",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Divider(
                                    //height: 20,
                                    thickness: 1,
                                    color: color.AppColor.NameWidget),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      );
}
