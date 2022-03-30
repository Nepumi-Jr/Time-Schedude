import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sendlink_application/back_end/time_sub.dart';
import 'package:sendlink_application/back_end/time_table.dart';
import 'package:sendlink_application/back_end/storage.dart';
import 'package:sendlink_application/back_end/subject.dart';
import 'package:sendlink_application/front_end/schedulepage.dart';
import 'package:tuple/tuple.dart';
import 'class_schedule.dart';
import 'colors.dart' as color;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

import 'listtodo.dart';

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
  late Tuple2<String, TimeSub> subject_during;
  late List<Tuple2<String, TimeSub>> subject_upnext = [];
  late List<Tuple2<String, TimeSub>> subject_done = [];

  // !To Do Variable
  List<dynamic> allToDoList = [];
  List<bool> checkedTodo = [];

  zeroCheck(int time) {
    if (time == 0) {
      return "00";
    } else if (time < 10) {
      return "0" + time.toString();
    } else {
      return time.toString();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openSubject();
    runningClock();
  }

  openSubject() {
    TimeTable.loadFile();
    dayInWeek = DateFormat("EEEEEE").format(DateTime.now()) as String;
    hourCheckInt = int.parse(DateFormat("HH").format(DateTime.now()));
    minuteCheckInt = int.parse(DateFormat("mm").format(DateTime.now()));
    subject_during =
        TimeTable.getSubjectAtTime(dayInWeek, hourCheckInt, minuteCheckInt);
    subject_upnext = TimeTable.getSubjectsIncomingAtTimeSameDay(
        dayInWeek, hourCheckInt, minuteCheckInt);
    subject_done = TimeTable.getSubjectsDoneAtTimeSameDay(
        dayInWeek, hourCheckInt, minuteCheckInt);
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
        openSubject();
      });
    });
  }

  goSchedule() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const schedule()),
    );
  }

  List<Widget> allToDo() {
    List<Widget> data = [];
    for (var i = 0; i < 5; i++) {
      data.add(
        Container(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 2,
                  ),
                  Checkbox(
                    value: checkedTodo[i],
                    activeColor: color.AppColor.Font_sub.withOpacity(0.5),
                    checkColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        checkedTodo[i] = !checkedTodo[i];
                      });
                    },
                  ),
                  Icon(
                    IconData(0xe158, fontFamily: 'MaterialIcons'),
                    color: color.AppColor.Gradient1,
                    size: 20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Differential Equation",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "work",
                          style: TextStyle(fontSize: 10, height: 0.7),
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
            ],
          ),
        ),
      );
    }
    return data;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          child: Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: color.AppColor.Gradient2,
                  borderRadius: BorderRadius.circular(15),
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
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 5,
                        color: Colors.grey.withOpacity(1))
                  ]),
              child: Center(
                child: Icon(
                  IconData(0xe385, fontFamily: 'MaterialIcons'),
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onPressed: () => goSchedule(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
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
                        width: 65 * MediaQuery.of(context).size.width / 400,
                      ),
                      Text(
                        timenow,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              80 * MediaQuery.of(context).size.width / 400,
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
                              fontSize:
                                  16 * MediaQuery.of(context).size.width / 400,
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
                        width: 70 * MediaQuery.of(context).size.width / 400,
                      ),
                      Text(day_month,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                16 * MediaQuery.of(context).size.width / 400,
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
            */
            ListClassSchedule(subject_during, subject_upnext, subject_done),
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
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 5, 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Add work",
                                              style: TextStyle(
                                                  color: color
                                                      .AppColor.NameWidget),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Divider(
                                    //height: 20,
                                    thickness: 1,
                                    color: color.AppColor.NameWidget),
                                Container(
                                  child: Row(
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                                ),

                                Divider(
                                    //height: 20,
                                    thickness: 1,
                                    color: color.AppColor.NameWidget),

                                Column(children: allToDo()),
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

                                //? This is add to do button
                                /* ListTile(
                          onTap: () {
                            print("to do pressed!");
                          },
                          leading: Icon(
                            IconData(
                              0xe047,
                              fontFamily: 'MaterialIcons',
                            ),
                          ),
                          title: Text("Add to do"),
                        ),
                        Divider(
                            //height: 20,
                            thickness: 1,
                            color: color.AppColor.NameWidget),
                         */ //? Under this line is all to do that in saved file.
                                //Row(children: allToDo(context)),
                                /* ListView.builder(
                          itemCount: dummyList.length,
                          itemBuilder: (context, index) => Card(
                            elevation: 6,
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(dummyList[index]["id"].toString()),
                                backgroundColor: Colors.purple,
                              ),
                              title: Text(dummyList[index]["title"]),
                              subtitle: Text(dummyList[index]["subtitle"]),
                              trailing: Icon(Icons.add_a_photo),
                            ),
                          ),
                        ), */
                                //? done title.
                                /*  ListTile(
                          onTap: () {
                            print("to do pressed!");
                          },
                          leading: Icon(
                            IconData(0xe098, fontFamily: 'MaterialIcons'),
                          ),
                          title: Text("Done"),
                        ),
                        Divider(
                            //height: 20,
                            thickness: 1,
                            color: color.AppColor.NameWidget),
 */
                                //? Under here is all done work.
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
            )
          ]),
        ),
      );
}
