import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendlink_application/back_end/time_table.dart';
import 'package:sendlink_application/back_end/storage.dart';
import 'package:sendlink_application/back_end/subject.dart';
import 'package:sendlink_application/front_end/checkbox_state.dart';
import 'colors.dart' as color;

class Addpage extends StatefulWidget {
  const Addpage({Key? key}) : super(key: key);

  @override
  _AddpageState createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
  TextEditingController _subject_name = TextEditingController();
  TextEditingController _link = TextEditingController();
  TextEditingController _place_name = TextEditingController();
  TextEditingController _time_start = TextEditingController();
  TextEditingController _time_end = TextEditingController();
  TextEditingController _date = TextEditingController();

  late List<TimeOfDay> time_start;
  late List<TimeOfDay> time_end;

  late TimeOfDay time_start_picker;
  late TimeOfDay time_end_picker;

  bool dayCheckSunday = false;
  bool dayCheckMonday = false;
  bool dayCheckTuesday = false;
  bool dayCheckWednesday = false;
  bool dayCheckThursday = false;
  bool dayCheckFriday = false;
  bool dayCheckSaturday = false;

  bool allDayCheckSunday = false;
  bool allDayCheckMonday = false;
  bool allDayCheckTuesday = false;
  bool allDayCheckWednesday = false;
  bool allDayCheckThursday = false;
  bool allDayCheckFriday = false;
  bool allDayCheckSaturday = false;

  late TimeOfDay picked;

  late String subject;

  bool value = false;

  List<CheckBoxState> dayInWeek = [];

  double _height = 60;
  double _width = 100;
  bool selected = false;

  List<double> moveDown = [0, 0, 0, 0, 0, 0, 0];
  List<double> extendDown = [60, 60, 60, 60, 60, 60, 60];

  /* final dayInWeek = {
    CheckBoxState(title: 'Monday'),
    CheckBoxState(title: 'Tuesday'),
    CheckBoxState
    
  (title: 'Wednesday'),
    CheckBoxState(title: 'Thursday'),
    CheckBoxState(title: 'Friday'),
    CheckBoxState(title: 'Saturday'),
    CheckBoxState(title: 'Sunday')
  }; */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    time_start_picker = TimeOfDay(hour: 0, minute: 0);
    time_end_picker = TimeOfDay(hour: 23, minute: 59);

    time_start = [
      TimeOfDay(hour: 0, minute: 0),
      TimeOfDay(hour: 0, minute: 0),
      TimeOfDay(hour: 0, minute: 0),
      TimeOfDay(hour: 0, minute: 0),
      TimeOfDay(hour: 0, minute: 0),
      TimeOfDay(hour: 0, minute: 0),
      TimeOfDay(hour: 0, minute: 0)
    ];

    time_end = [
      TimeOfDay(hour: 23, minute: 59),
      TimeOfDay(hour: 23, minute: 59),
      TimeOfDay(hour: 23, minute: 59),
      TimeOfDay(hour: 23, minute: 59),
      TimeOfDay(hour: 23, minute: 59),
      TimeOfDay(hour: 23, minute: 59),
      TimeOfDay(hour: 23, minute: 59)
    ];
  }

  /* Future<File> _incrementCounter() {
    setState(() {
      subject = TimeTable.timetable.toString();
    });

    // Write the variable as a string to the file.
    return Storage.writeSubject(subject);
  } */

  Future<Null> selectTimeStart(BuildContext context, int day) async {
    picked =
        (await showTimePicker(context: context, initialTime: time_start[day]))!;

    if (picked != null) {
      setState(() {
        time_start[day] = picked;
        if (time_start[day].hour > time_end[day].hour ||
            ((time_start[day].hour == time_end[day].hour) &&
                time_start[day].minute > time_end[day].minute)) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Invalid time input'),
              content:
                  const Text('The start time should be before the end time.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          time_start[day] = TimeOfDay(hour: 0, minute: 0);
        }
      });
    }
  }

  Future<Null> selectTimeEnd(BuildContext context, int day) async {
    picked =
        (await showTimePicker(context: context, initialTime: time_end[day]))!;

    if (picked != null) {
      setState(() {
        time_end[day] = picked;
        if (time_start[day].hour > time_end[day].hour ||
            ((time_start[day].hour == time_end[day].hour) &&
                time_start[day].minute > time_end[day].minute)) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Invalid time input'),
              content:
                  const Text('The start time should be before the end time.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          time_end[day] = TimeOfDay(hour: 23, minute: 59);
        } else {
          setState(() {
            moveDown[day] = 0;
            extendDown[day] = 60;
          });
        }
      });
    }
  }

  zeroMinCheck(TimeOfDay time) {
    if (time.minute == 0) {
      return "00";
    } else if (time.minute < 10) {
      return "0" + time.minute.toString();
    } else {
      return time.minute.toString();
    }
  }

  zeroHourCheck(TimeOfDay time) {
    if (time.hour == 0) {
      return "00";
    } else if (time.hour < 10) {
      return "0" + time.hour.toString();
    } else {
      return time.hour.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 35),
          child: Column(children: [
            // Go back Icon.
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Container(
                  width: 53,
                  height: 31,
                  decoration: BoxDecoration(
                      color: color.AppColor.Gradient2,
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                          colors: [
                            color.AppColor.Gradient1,
                            color.AppColor.Gradient1.withOpacity(0.8),
                            color.AppColor.Gradient2.withOpacity(0.8),
                            color.AppColor.Gradient2,
                            //add more colors for gradient
                          ],
                          begin:
                              Alignment.topRight, //begin of the gradient color
                          end: Alignment.bottomLeft, //end of the gradient color
                          stops: const [
                            0,
                            0.1,
                            0.9,
                            1
                          ] //stops for individual color
                          //set the stops number equal to numbers of color
                          ),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 5,
                            color: Colors.grey.withOpacity(1))
                      ]),
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 13.5,
                      ),
                      Icon(
                        IconData(0xf570, fontFamily: 'MaterialIcons'),
                        size: 25,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // invis box.
            SizedBox(
              height: 10,
            ),

            // Head line.
            Row(
              children: [
                SizedBox(
                  width: 45,
                ),
                Text(
                  "Class Addpage",
                  style: TextStyle(
                      fontSize: 20,
                      color: color.AppColor.NamePage,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),

            // invis box.
            SizedBox(
              height: 10,
            ),

            // * * Container for other information
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
              margin: EdgeInsets.fromLTRB(25, 0, 25, 5),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: color.AppColor.WidgetBackground.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20), //border corner radius
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(children: [
                    SizedBox(width: 10),
                    Text("Class name",
                        style: TextStyle(
                            fontSize: 20,
                            color: color.AppColor.Font_sub,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: color.AppColor.box_class.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: TextField(
                        controller: _subject_name,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            fontWeight: FontWeight.normal,
                            color: color.AppColor.NamePage),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Subject name',
                            hintStyle: TextStyle(
                                fontSize: 20.0,
                                color: color.AppColor.background_textfield)),
                      ),
                    ),
                  ),
                  Row(children: [
                    SizedBox(width: 10),
                    Text("Link",
                        style: TextStyle(
                            fontSize: 20,
                            color: color.AppColor.Font_sub,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: color.AppColor.box_class.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: TextField(
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            fontWeight: FontWeight.normal,
                            color: color.AppColor.NamePage),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Class Link',
                            hintStyle: TextStyle(
                                fontSize: 20.0,
                                color: color.AppColor.background_textfield)),
                      ),
                    ),
                  ),
                  Row(children: [
                    SizedBox(width: 10),
                    Text("On-site at",
                        style: TextStyle(
                            fontSize: 20,
                            color: color.AppColor.Font_sub,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: color.AppColor.box_class.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: TextField(
                        controller: _place_name,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            fontWeight: FontWeight.normal,
                            color: color.AppColor.NamePage),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Place.',
                            hintStyle: TextStyle(
                                fontSize: 20.0,
                                color: color.AppColor.background_textfield)),
                      ),
                    ),
                  ),
                  SizedBox(height: 2),
                  Row(children: [
                    SizedBox(width: 10),
                    Text("Meeting Day",
                        style: TextStyle(
                            fontSize: 18,
                            color: color.AppColor.Font_sub,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          width: double.infinity,
                          /* decoration: BoxDecoration(
                            color: color.AppColor.box_class.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ), */
                          child: Container(
                            child: Column(
                              children: [
                                AnimatedContainer(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn,
                                  height: extendDown[0],
                                  decoration: BoxDecoration(
                                    //color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ), //BorderRadius.Only
                                  ),
                                  child: Stack(
                                    children: [
                                      /* Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              margin: EdgeInsets.fromLTRB(
                                                  15, 20, 15, 0),
                                              curve: Curves.easeInOutExpo,
                                              height: _height,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.box_class
                                                    .withOpacity(0.5),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(5),
                                                  bottomRight: Radius.circular(5),
                                                ), //BorderRadius.Only
                                              ),
                                              child: Row(
                                                children: [],
                                              )),
                                          /*  AnimatedPositioned(
                                              child: Container(),
                                              duration: Duration(seconds: 2)), */
                                          SizedBox(
                                            width: 25,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectTimeStart(context);
                                            }, // Handle your callback
                                            child: Ink(
                                              height: 40,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.Font_sub,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${zeroHourCheck(time_start_picker)}:${zeroMinCheck(time_start_picker)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          Text(" to",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: color.AppColor.Font_sub,
                                                  fontWeight: FontWeight.bold)),
                                          Expanded(child: Container()),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectTimeStart(context);
                                            }, // Handle your callback
                                            child: Ink(
                                              height: 40,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.Font_sub,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${zeroHourCheck(time_start_picker)}:${zeroMinCheck(time_start_picker)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                        ],
                                      ), */
                                      AnimatedPositioned(
                                        //height: 60.0,
                                        child: Container(
                                          //color: Colors.blue,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    //color: Colors.purple,
                                                    //height: 10,
                                                    //width: 10,
                                                    child: Column(
                                                      children: [
                                                        Text("Start at:",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: color
                                                                    .AppColor
                                                                    .Font_sub,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        InkWell(
                                                          onTap: () {
                                                            selectTimeStart(
                                                                context, 0);
                                                          }, // Handle your callback
                                                          child: Ink(
                                                            height: 35,
                                                            width: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: color
                                                                  .AppColor
                                                                  .Font_sub,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${zeroHourCheck(time_start[0])}:${zeroMinCheck(time_start[0])}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 17, 0, 0),
                                                    child: Text("to",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: color
                                                                .AppColor
                                                                .Font_sub,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    //color: Colors.purple,
                                                    //height: 10,
                                                    //width: 10,
                                                    child: Column(
                                                      children: [
                                                        Text("End at:",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: color
                                                                    .AppColor
                                                                    .Font_sub,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        InkWell(
                                                          onTap: () {
                                                            selectTimeEnd(
                                                                context, 0);
                                                          }, // Handle your callback
                                                          child: Ink(
                                                            height: 35,
                                                            width: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: color
                                                                  .AppColor
                                                                  .Font_sub,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${zeroHourCheck(time_end[0])}:${zeroMinCheck(time_end[0])}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(0, 5,
                                                                    0, 0),
                                                            child: Text(
                                                                "All day",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: color
                                                                        .AppColor
                                                                        .Font_sub,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                        SizedBox(
                                                          width: 30,
                                                          height: 35,
                                                          child: Checkbox(
                                                              value:
                                                                  allDayCheckMonday,
                                                              activeColor: color
                                                                  .AppColor
                                                                  .Font_sub
                                                                  .withOpacity(
                                                                      0.5),
                                                              checkColor:
                                                                  Colors.white,
                                                              onChanged:
                                                                  (value) =>
                                                                      setState(
                                                                          () {
                                                                        this.allDayCheckMonday =
                                                                            !(allDayCheckMonday);
                                                                        if (allDayCheckMonday ==
                                                                            false) {
                                                                        } else {
                                                                          _increaseWidth(
                                                                              0);
                                                                          _increaseHeight(
                                                                              0);
                                                                          setState(
                                                                              () {
                                                                            time_start[0] =
                                                                                TimeOfDay(hour: 0, minute: 0);
                                                                            time_end[0] =
                                                                                TimeOfDay(hour: 23, minute: 59);
                                                                          });
                                                                        }
                                                                      })),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 500),
                                        top: moveDown[0],
                                        curve: Curves.fastOutSlowIn,
                                      ),
                                      Container(
                                        //BackGround
                                        padding: const EdgeInsets.all(5),
                                        height: 60,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selected = !(selected);
                                          });
                                          if (value == false) {
                                            setState(() {
                                              value = !(value);
                                              moveDown[0] = 60;
                                              extendDown[0] = 120;
                                            });
                                          } else {
                                            setState(() {
                                              _increaseWidth(0);
                                              _increaseHeight(0);
                                            });
                                          }
                                        }, //
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          height: 60,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              // color: color.AppColor.Gradient2.withOpacity(1),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    color.AppColor.Gradient1,
                                                    color.AppColor.Gradient1
                                                        .withOpacity(0.9),
                                                    color.AppColor.Gradient2
                                                        .withOpacity(0.9),
                                                    color.AppColor.Gradient2,
                                                    //add more colors for gradient
                                                  ],
                                                  begin: Alignment
                                                      .topRight, //begin of the gradient color
                                                  end: Alignment
                                                      .bottomLeft, //end of the gradient color
                                                  stops: const [
                                                    0,
                                                    0.1,
                                                    0.9,
                                                    1
                                                  ] //st the stops number equal to numbers of color
                                                  ),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0, 5),
                                                    blurRadius: 5,
                                                    color: Colors.grey
                                                        .withOpacity(1))
                                              ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: value,
                                                  activeColor: Colors.white,
                                                  checkColor:
                                                      color.AppColor.Gradient2,
                                                  onChanged: (value) =>
                                                      setState(() {
                                                        this.value = value!;
                                                        if (value == false) {
                                                          setState(() {
                                                            moveDown[0] = 0;
                                                            extendDown[0] = 60;
                                                            allDayCheckMonday =
                                                                false;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            moveDown[0] = 60;
                                                            extendDown[0] = 120;
                                                          });
                                                        }
                                                      })),
                                              Center(
                                                child: Text(
                                                  "Monday",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 35,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedContainer(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn,
                                  height: extendDown[0],
                                  decoration: BoxDecoration(
                                    //color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ), //BorderRadius.Only
                                  ),
                                  child: Stack(
                                    children: [
                                      /* Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              margin: EdgeInsets.fromLTRB(
                                                  15, 20, 15, 0),
                                              curve: Curves.easeInOutExpo,
                                              height: _height,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.box_class
                                                    .withOpacity(0.5),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(5),
                                                  bottomRight: Radius.circular(5),
                                                ), //BorderRadius.Only
                                              ),
                                              child: Row(
                                                children: [],
                                              )),
                                          /*  AnimatedPositioned(
                                              child: Container(),
                                              duration: Duration(seconds: 2)), */
                                          SizedBox(
                                            width: 25,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectTimeStart(context);
                                            }, // Handle your callback
                                            child: Ink(
                                              height: 40,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.Font_sub,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${zeroHourCheck(time_start_picker)}:${zeroMinCheck(time_start_picker)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          Text(" to",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: color.AppColor.Font_sub,
                                                  fontWeight: FontWeight.bold)),
                                          Expanded(child: Container()),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectTimeStart(context);
                                            }, // Handle your callback
                                            child: Ink(
                                              height: 40,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.Font_sub,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${zeroHourCheck(time_start_picker)}:${zeroMinCheck(time_start_picker)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                        ],
                                      ), */
                                      AnimatedPositioned(
                                        //height: 60.0,
                                        child: Container(
                                          //color: Colors.blue,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    //color: Colors.purple,
                                                    //height: 10,
                                                    //width: 10,
                                                    child: Column(
                                                      children: [
                                                        Text("Start at:",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: color
                                                                    .AppColor
                                                                    .Font_sub,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        InkWell(
                                                          onTap: () {
                                                            selectTimeStart(
                                                                context, 0);
                                                          }, // Handle your callback
                                                          child: Ink(
                                                            height: 35,
                                                            width: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: color
                                                                  .AppColor
                                                                  .Font_sub,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${zeroHourCheck(time_start[0])}:${zeroMinCheck(time_start[0])}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 17, 0, 0),
                                                    child: Text("to",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: color
                                                                .AppColor
                                                                .Font_sub,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    //color: Colors.purple,
                                                    //height: 10,
                                                    //width: 10,
                                                    child: Column(
                                                      children: [
                                                        Text("End at:",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: color
                                                                    .AppColor
                                                                    .Font_sub,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        InkWell(
                                                          onTap: () {
                                                            selectTimeEnd(
                                                                context, 0);
                                                          }, // Handle your callback
                                                          child: Ink(
                                                            height: 35,
                                                            width: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: color
                                                                  .AppColor
                                                                  .Font_sub,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${zeroHourCheck(time_end[0])}:${zeroMinCheck(time_end[0])}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(0, 5,
                                                                    0, 0),
                                                            child: Text(
                                                                "All day",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: color
                                                                        .AppColor
                                                                        .Font_sub,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                        SizedBox(
                                                          width: 30,
                                                          height: 35,
                                                          child: Checkbox(
                                                              value:
                                                                  allDayCheckMonday,
                                                              activeColor: color
                                                                  .AppColor
                                                                  .Font_sub
                                                                  .withOpacity(
                                                                      0.5),
                                                              checkColor:
                                                                  Colors.white,
                                                              onChanged:
                                                                  (value) =>
                                                                      setState(
                                                                          () {
                                                                        this.allDayCheckMonday =
                                                                            !(allDayCheckMonday);
                                                                        if (allDayCheckMonday ==
                                                                            false) {
                                                                        } else {
                                                                          _increaseWidth(
                                                                              0);
                                                                          _increaseHeight(
                                                                              0);
                                                                          setState(
                                                                              () {
                                                                            time_start[0] =
                                                                                TimeOfDay(hour: 0, minute: 0);
                                                                            time_end[0] =
                                                                                TimeOfDay(hour: 23, minute: 59);
                                                                          });
                                                                        }
                                                                      })),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 500),
                                        top: moveDown[0],
                                        curve: Curves.fastOutSlowIn,
                                      ),
                                      Container(
                                        //BackGround
                                        padding: const EdgeInsets.all(5),
                                        height: 60,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selected = !(selected);
                                          });
                                          if (value == false) {
                                            setState(() {
                                              value = !(value);
                                              moveDown[0] = 60;
                                              extendDown[0] = 120;
                                            });
                                          } else {
                                            setState(() {
                                              _increaseWidth(0);
                                              _increaseHeight(0);
                                            });
                                          }
                                        }, //
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          height: 60,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              // color: color.AppColor.Gradient2.withOpacity(1),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    color.AppColor.Gradient1,
                                                    color.AppColor.Gradient1
                                                        .withOpacity(0.9),
                                                    color.AppColor.Gradient2
                                                        .withOpacity(0.9),
                                                    color.AppColor.Gradient2,
                                                    //add more colors for gradient
                                                  ],
                                                  begin: Alignment
                                                      .topRight, //begin of the gradient color
                                                  end: Alignment
                                                      .bottomLeft, //end of the gradient color
                                                  stops: const [
                                                    0,
                                                    0.1,
                                                    0.9,
                                                    1
                                                  ] //st the stops number equal to numbers of color
                                                  ),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0, 5),
                                                    blurRadius: 5,
                                                    color: Colors.grey
                                                        .withOpacity(1))
                                              ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: value,
                                                  activeColor: Colors.white,
                                                  checkColor:
                                                      color.AppColor.Gradient2,
                                                  onChanged: (value) =>
                                                      setState(() {
                                                        this.value = value!;
                                                        if (value == false) {
                                                          setState(() {
                                                            moveDown[0] = 0;
                                                            extendDown[0] = 60;
                                                            allDayCheckMonday =
                                                                false;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            moveDown[0] = 60;
                                                            extendDown[0] = 120;
                                                          });
                                                        }
                                                      })),
                                              Center(
                                                child: Text(
                                                  "Monday",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 35,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedContainer(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn,
                                  height: extendDown[0],
                                  decoration: BoxDecoration(
                                    //color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ), //BorderRadius.Only
                                  ),
                                  child: Stack(
                                    children: [
                                      /* Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              margin: EdgeInsets.fromLTRB(
                                                  15, 20, 15, 0),
                                              curve: Curves.easeInOutExpo,
                                              height: _height,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.box_class
                                                    .withOpacity(0.5),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(5),
                                                  bottomRight: Radius.circular(5),
                                                ), //BorderRadius.Only
                                              ),
                                              child: Row(
                                                children: [],
                                              )),
                                          /*  AnimatedPositioned(
                                              child: Container(),
                                              duration: Duration(seconds: 2)), */
                                          SizedBox(
                                            width: 25,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectTimeStart(context);
                                            }, // Handle your callback
                                            child: Ink(
                                              height: 40,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.Font_sub,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${zeroHourCheck(time_start_picker)}:${zeroMinCheck(time_start_picker)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          Text(" to",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: color.AppColor.Font_sub,
                                                  fontWeight: FontWeight.bold)),
                                          Expanded(child: Container()),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectTimeStart(context);
                                            }, // Handle your callback
                                            child: Ink(
                                              height: 40,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.Font_sub,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${zeroHourCheck(time_start_picker)}:${zeroMinCheck(time_start_picker)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                        ],
                                      ), */
                                      AnimatedPositioned(
                                        //height: 60.0,
                                        child: Container(
                                          //color: Colors.blue,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    //color: Colors.purple,
                                                    //height: 10,
                                                    //width: 10,
                                                    child: Column(
                                                      children: [
                                                        Text("Start at:",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: color
                                                                    .AppColor
                                                                    .Font_sub,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        InkWell(
                                                          onTap: () {
                                                            selectTimeStart(
                                                                context, 0);
                                                          }, // Handle your callback
                                                          child: Ink(
                                                            height: 35,
                                                            width: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: color
                                                                  .AppColor
                                                                  .Font_sub,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${zeroHourCheck(time_start[0])}:${zeroMinCheck(time_start[0])}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 17, 0, 0),
                                                    child: Text("to",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: color
                                                                .AppColor
                                                                .Font_sub,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    //color: Colors.purple,
                                                    //height: 10,
                                                    //width: 10,
                                                    child: Column(
                                                      children: [
                                                        Text("End at:",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: color
                                                                    .AppColor
                                                                    .Font_sub,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        InkWell(
                                                          onTap: () {
                                                            selectTimeEnd(
                                                                context, 0);
                                                          }, // Handle your callback
                                                          child: Ink(
                                                            height: 35,
                                                            width: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: color
                                                                  .AppColor
                                                                  .Font_sub,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${zeroHourCheck(time_end[0])}:${zeroMinCheck(time_end[0])}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(0, 5,
                                                                    0, 0),
                                                            child: Text(
                                                                "All day",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: color
                                                                        .AppColor
                                                                        .Font_sub,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                        SizedBox(
                                                          width: 30,
                                                          height: 35,
                                                          child: Checkbox(
                                                              value:
                                                                  allDayCheckMonday,
                                                              activeColor: color
                                                                  .AppColor
                                                                  .Font_sub
                                                                  .withOpacity(
                                                                      0.5),
                                                              checkColor:
                                                                  Colors.white,
                                                              onChanged:
                                                                  (value) =>
                                                                      setState(
                                                                          () {
                                                                        this.allDayCheckMonday =
                                                                            !(allDayCheckMonday);
                                                                        if (allDayCheckMonday ==
                                                                            false) {
                                                                        } else {
                                                                          _increaseWidth(
                                                                              0);
                                                                          _increaseHeight(
                                                                              0);
                                                                          setState(
                                                                              () {
                                                                            time_start[0] =
                                                                                TimeOfDay(hour: 0, minute: 0);
                                                                            time_end[0] =
                                                                                TimeOfDay(hour: 23, minute: 59);
                                                                          });
                                                                        }
                                                                      })),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 500),
                                        top: moveDown[0],
                                        curve: Curves.fastOutSlowIn,
                                      ),
                                      Container(
                                        //BackGround
                                        padding: const EdgeInsets.all(5),
                                        height: 60,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selected = !(selected);
                                          });
                                          if (value == false) {
                                            setState(() {
                                              value = !(value);
                                              moveDown[0] = 60;
                                              extendDown[0] = 120;
                                            });
                                          } else {
                                            setState(() {
                                              _increaseWidth(0);
                                              _increaseHeight(0);
                                            });
                                          }
                                        }, //
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          height: 60,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              // color: color.AppColor.Gradient2.withOpacity(1),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    color.AppColor.Gradient1,
                                                    color.AppColor.Gradient1
                                                        .withOpacity(0.9),
                                                    color.AppColor.Gradient2
                                                        .withOpacity(0.9),
                                                    color.AppColor.Gradient2,
                                                    //add more colors for gradient
                                                  ],
                                                  begin: Alignment
                                                      .topRight, //begin of the gradient color
                                                  end: Alignment
                                                      .bottomLeft, //end of the gradient color
                                                  stops: const [
                                                    0,
                                                    0.1,
                                                    0.9,
                                                    1
                                                  ] //st the stops number equal to numbers of color
                                                  ),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0, 5),
                                                    blurRadius: 5,
                                                    color: Colors.grey
                                                        .withOpacity(1))
                                              ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: value,
                                                  activeColor: Colors.white,
                                                  checkColor:
                                                      color.AppColor.Gradient2,
                                                  onChanged: (value) =>
                                                      setState(() {
                                                        this.value = value!;
                                                        if (value == false) {
                                                          setState(() {
                                                            moveDown[0] = 0;
                                                            extendDown[0] = 60;
                                                            allDayCheckMonday =
                                                                false;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            moveDown[0] = 60;
                                                            extendDown[0] = 120;
                                                          });
                                                        }
                                                      })),
                                              Center(
                                                child: Text(
                                                  "Monday",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 35,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedContainer(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn,
                                  height: extendDown[0],
                                  decoration: BoxDecoration(
                                    //color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ), //BorderRadius.Only
                                  ),
                                  child: Stack(
                                    children: [
                                      /* Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              margin: EdgeInsets.fromLTRB(
                                                  15, 20, 15, 0),
                                              curve: Curves.easeInOutExpo,
                                              height: _height,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.box_class
                                                    .withOpacity(0.5),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(5),
                                                  bottomRight: Radius.circular(5),
                                                ), //BorderRadius.Only
                                              ),
                                              child: Row(
                                                children: [],
                                              )),
                                          /*  AnimatedPositioned(
                                              child: Container(),
                                              duration: Duration(seconds: 2)), */
                                          SizedBox(
                                            width: 25,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectTimeStart(context);
                                            }, // Handle your callback
                                            child: Ink(
                                              height: 40,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.Font_sub,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${zeroHourCheck(time_start_picker)}:${zeroMinCheck(time_start_picker)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          Text(" to",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: color.AppColor.Font_sub,
                                                  fontWeight: FontWeight.bold)),
                                          Expanded(child: Container()),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectTimeStart(context);
                                            }, // Handle your callback
                                            child: Ink(
                                              height: 40,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.Font_sub,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${zeroHourCheck(time_start_picker)}:${zeroMinCheck(time_start_picker)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                        ],
                                      ), */
                                      AnimatedPositioned(
                                        //height: 60.0,
                                        child: Container(
                                          //color: Colors.blue,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    //color: Colors.purple,
                                                    //height: 10,
                                                    //width: 10,
                                                    child: Column(
                                                      children: [
                                                        Text("Start at:",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: color
                                                                    .AppColor
                                                                    .Font_sub,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        InkWell(
                                                          onTap: () {
                                                            selectTimeStart(
                                                                context, 0);
                                                          }, // Handle your callback
                                                          child: Ink(
                                                            height: 35,
                                                            width: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: color
                                                                  .AppColor
                                                                  .Font_sub,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${zeroHourCheck(time_start[0])}:${zeroMinCheck(time_start[0])}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 17, 0, 0),
                                                    child: Text("to",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: color
                                                                .AppColor
                                                                .Font_sub,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    //color: Colors.purple,
                                                    //height: 10,
                                                    //width: 10,
                                                    child: Column(
                                                      children: [
                                                        Text("End at:",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: color
                                                                    .AppColor
                                                                    .Font_sub,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        InkWell(
                                                          onTap: () {
                                                            selectTimeEnd(
                                                                context, 0);
                                                          }, // Handle your callback
                                                          child: Ink(
                                                            height: 35,
                                                            width: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: color
                                                                  .AppColor
                                                                  .Font_sub,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${zeroHourCheck(time_end[0])}:${zeroMinCheck(time_end[0])}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(0, 5,
                                                                    0, 0),
                                                            child: Text(
                                                                "All day",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: color
                                                                        .AppColor
                                                                        .Font_sub,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                        SizedBox(
                                                          width: 30,
                                                          height: 35,
                                                          child: Checkbox(
                                                              value:
                                                                  allDayCheckMonday,
                                                              activeColor: color
                                                                  .AppColor
                                                                  .Font_sub
                                                                  .withOpacity(
                                                                      0.5),
                                                              checkColor:
                                                                  Colors.white,
                                                              onChanged:
                                                                  (value) =>
                                                                      setState(
                                                                          () {
                                                                        this.allDayCheckMonday =
                                                                            !(allDayCheckMonday);
                                                                        if (allDayCheckMonday ==
                                                                            false) {
                                                                        } else {
                                                                          _increaseWidth(
                                                                              0);
                                                                          _increaseHeight(
                                                                              0);
                                                                          setState(
                                                                              () {
                                                                            time_start[0] =
                                                                                TimeOfDay(hour: 0, minute: 0);
                                                                            time_end[0] =
                                                                                TimeOfDay(hour: 23, minute: 59);
                                                                          });
                                                                        }
                                                                      })),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 500),
                                        top: moveDown[0],
                                        curve: Curves.fastOutSlowIn,
                                      ),
                                      Container(
                                        //BackGround
                                        padding: const EdgeInsets.all(5),
                                        height: 60,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selected = !(selected);
                                          });
                                          if (value == false) {
                                            setState(() {
                                              value = !(value);
                                              moveDown[0] = 60;
                                              extendDown[0] = 120;
                                            });
                                          } else {
                                            setState(() {
                                              _increaseWidth(0);
                                              _increaseHeight(0);
                                            });
                                          }
                                        }, //
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          height: 60,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              // color: color.AppColor.Gradient2.withOpacity(1),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    color.AppColor.Gradient1,
                                                    color.AppColor.Gradient1
                                                        .withOpacity(0.9),
                                                    color.AppColor.Gradient2
                                                        .withOpacity(0.9),
                                                    color.AppColor.Gradient2,
                                                    //add more colors for gradient
                                                  ],
                                                  begin: Alignment
                                                      .topRight, //begin of the gradient color
                                                  end: Alignment
                                                      .bottomLeft, //end of the gradient color
                                                  stops: const [
                                                    0,
                                                    0.1,
                                                    0.9,
                                                    1
                                                  ] //st the stops number equal to numbers of color
                                                  ),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0, 5),
                                                    blurRadius: 5,
                                                    color: Colors.grey
                                                        .withOpacity(1))
                                              ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: value,
                                                  activeColor: Colors.white,
                                                  checkColor:
                                                      color.AppColor.Gradient2,
                                                  onChanged: (value) =>
                                                      setState(() {
                                                        this.value = value!;
                                                        if (value == false) {
                                                          setState(() {
                                                            moveDown[0] = 0;
                                                            extendDown[0] = 60;
                                                            allDayCheckMonday =
                                                                false;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            moveDown[0] = 60;
                                                            extendDown[0] = 120;
                                                          });
                                                        }
                                                      })),
                                              Center(
                                                child: Text(
                                                  "Monday",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 35,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedContainer(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn,
                                  height: extendDown[0],
                                  decoration: BoxDecoration(
                                    //color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ), //BorderRadius.Only
                                  ),
                                  child: Stack(
                                    children: [
                                      /* Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              margin: EdgeInsets.fromLTRB(
                                                  15, 20, 15, 0),
                                              curve: Curves.easeInOutExpo,
                                              height: _height,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.box_class
                                                    .withOpacity(0.5),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(5),
                                                  bottomRight: Radius.circular(5),
                                                ), //BorderRadius.Only
                                              ),
                                              child: Row(
                                                children: [],
                                              )),
                                          /*  AnimatedPositioned(
                                              child: Container(),
                                              duration: Duration(seconds: 2)), */
                                          SizedBox(
                                            width: 25,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectTimeStart(context);
                                            }, // Handle your callback
                                            child: Ink(
                                              height: 40,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.Font_sub,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${zeroHourCheck(time_start_picker)}:${zeroMinCheck(time_start_picker)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          Text(" to",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: color.AppColor.Font_sub,
                                                  fontWeight: FontWeight.bold)),
                                          Expanded(child: Container()),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectTimeStart(context);
                                            }, // Handle your callback
                                            child: Ink(
                                              height: 40,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.Font_sub,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${zeroHourCheck(time_start_picker)}:${zeroMinCheck(time_start_picker)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                        ],
                                      ), */
                                      AnimatedPositioned(
                                        //height: 60.0,
                                        child: Container(
                                          //color: Colors.blue,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    //color: Colors.purple,
                                                    //height: 10,
                                                    //width: 10,
                                                    child: Column(
                                                      children: [
                                                        Text("Start at:",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: color
                                                                    .AppColor
                                                                    .Font_sub,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        InkWell(
                                                          onTap: () {
                                                            selectTimeStart(
                                                                context, 0);
                                                          }, // Handle your callback
                                                          child: Ink(
                                                            height: 35,
                                                            width: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: color
                                                                  .AppColor
                                                                  .Font_sub,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${zeroHourCheck(time_start[0])}:${zeroMinCheck(time_start[0])}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 17, 0, 0),
                                                    child: Text("to",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: color
                                                                .AppColor
                                                                .Font_sub,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    //color: Colors.purple,
                                                    //height: 10,
                                                    //width: 10,
                                                    child: Column(
                                                      children: [
                                                        Text("End at:",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: color
                                                                    .AppColor
                                                                    .Font_sub,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        InkWell(
                                                          onTap: () {
                                                            selectTimeEnd(
                                                                context, 0);
                                                          }, // Handle your callback
                                                          child: Ink(
                                                            height: 35,
                                                            width: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: color
                                                                  .AppColor
                                                                  .Font_sub,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${zeroHourCheck(time_end[0])}:${zeroMinCheck(time_end[0])}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(0, 5,
                                                                    0, 0),
                                                            child: Text(
                                                                "All day",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: color
                                                                        .AppColor
                                                                        .Font_sub,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                        SizedBox(
                                                          width: 30,
                                                          height: 35,
                                                          child: Checkbox(
                                                              value:
                                                                  allDayCheckMonday,
                                                              activeColor: color
                                                                  .AppColor
                                                                  .Font_sub
                                                                  .withOpacity(
                                                                      0.5),
                                                              checkColor:
                                                                  Colors.white,
                                                              onChanged:
                                                                  (value) =>
                                                                      setState(
                                                                          () {
                                                                        this.allDayCheckMonday =
                                                                            !(allDayCheckMonday);
                                                                        if (allDayCheckMonday ==
                                                                            false) {
                                                                        } else {
                                                                          _increaseWidth(
                                                                              0);
                                                                          _increaseHeight(
                                                                              0);
                                                                          setState(
                                                                              () {
                                                                            time_start[0] =
                                                                                TimeOfDay(hour: 0, minute: 0);
                                                                            time_end[0] =
                                                                                TimeOfDay(hour: 23, minute: 59);
                                                                          });
                                                                        }
                                                                      })),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 500),
                                        top: moveDown[0],
                                        curve: Curves.fastOutSlowIn,
                                      ),
                                      Container(
                                        //BackGround
                                        padding: const EdgeInsets.all(5),
                                        height: 60,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selected = !(selected);
                                          });
                                          if (value == false) {
                                            setState(() {
                                              value = !(value);
                                              moveDown[0] = 60;
                                              extendDown[0] = 120;
                                            });
                                          } else {
                                            setState(() {
                                              _increaseWidth(0);
                                              _increaseHeight(0);
                                            });
                                          }
                                        }, //
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          height: 60,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              // color: color.AppColor.Gradient2.withOpacity(1),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    color.AppColor.Gradient1,
                                                    color.AppColor.Gradient1
                                                        .withOpacity(0.9),
                                                    color.AppColor.Gradient2
                                                        .withOpacity(0.9),
                                                    color.AppColor.Gradient2,
                                                    //add more colors for gradient
                                                  ],
                                                  begin: Alignment
                                                      .topRight, //begin of the gradient color
                                                  end: Alignment
                                                      .bottomLeft, //end of the gradient color
                                                  stops: const [
                                                    0,
                                                    0.1,
                                                    0.9,
                                                    1
                                                  ] //st the stops number equal to numbers of color
                                                  ),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0, 5),
                                                    blurRadius: 5,
                                                    color: Colors.grey
                                                        .withOpacity(1))
                                              ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: value,
                                                  activeColor: Colors.white,
                                                  checkColor:
                                                      color.AppColor.Gradient2,
                                                  onChanged: (value) =>
                                                      setState(() {
                                                        this.value = value!;
                                                        if (value == false) {
                                                          setState(() {
                                                            moveDown[0] = 0;
                                                            extendDown[0] = 60;
                                                            allDayCheckMonday =
                                                                false;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            moveDown[0] = 60;
                                                            extendDown[0] = 120;
                                                          });
                                                        }
                                                      })),
                                              Center(
                                                child: Text(
                                                  "Monday",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 35,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedContainer(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn,
                                  height: extendDown[0],
                                  decoration: BoxDecoration(
                                    //color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ), //BorderRadius.Only
                                  ),
                                  child: Stack(
                                    children: [
                                      /* Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              margin: EdgeInsets.fromLTRB(
                                                  15, 20, 15, 0),
                                              curve: Curves.easeInOutExpo,
                                              height: _height,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.box_class
                                                    .withOpacity(0.5),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(5),
                                                  bottomRight: Radius.circular(5),
                                                ), //BorderRadius.Only
                                              ),
                                              child: Row(
                                                children: [],
                                              )),
                                          /*  AnimatedPositioned(
                                              child: Container(),
                                              duration: Duration(seconds: 2)), */
                                          SizedBox(
                                            width: 25,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectTimeStart(context);
                                            }, // Handle your callback
                                            child: Ink(
                                              height: 40,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.Font_sub,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${zeroHourCheck(time_start_picker)}:${zeroMinCheck(time_start_picker)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          Text(" to",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: color.AppColor.Font_sub,
                                                  fontWeight: FontWeight.bold)),
                                          Expanded(child: Container()),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectTimeStart(context);
                                            }, // Handle your callback
                                            child: Ink(
                                              height: 40,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.Font_sub,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${zeroHourCheck(time_start_picker)}:${zeroMinCheck(time_start_picker)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                        ],
                                      ), */
                                      AnimatedPositioned(
                                        //height: 60.0,
                                        child: Container(
                                          //color: Colors.blue,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    //color: Colors.purple,
                                                    //height: 10,
                                                    //width: 10,
                                                    child: Column(
                                                      children: [
                                                        Text("Start at:",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: color
                                                                    .AppColor
                                                                    .Font_sub,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        InkWell(
                                                          onTap: () {
                                                            selectTimeStart(
                                                                context, 0);
                                                          }, // Handle your callback
                                                          child: Ink(
                                                            height: 35,
                                                            width: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: color
                                                                  .AppColor
                                                                  .Font_sub,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${zeroHourCheck(time_start[0])}:${zeroMinCheck(time_start[0])}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 17, 0, 0),
                                                    child: Text("to",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: color
                                                                .AppColor
                                                                .Font_sub,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    //color: Colors.purple,
                                                    //height: 10,
                                                    //width: 10,
                                                    child: Column(
                                                      children: [
                                                        Text("End at:",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: color
                                                                    .AppColor
                                                                    .Font_sub,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        InkWell(
                                                          onTap: () {
                                                            selectTimeEnd(
                                                                context, 0);
                                                          }, // Handle your callback
                                                          child: Ink(
                                                            height: 35,
                                                            width: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: color
                                                                  .AppColor
                                                                  .Font_sub,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${zeroHourCheck(time_end[0])}:${zeroMinCheck(time_end[0])}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(0, 5,
                                                                    0, 0),
                                                            child: Text(
                                                                "All day",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: color
                                                                        .AppColor
                                                                        .Font_sub,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                        SizedBox(
                                                          width: 30,
                                                          height: 35,
                                                          child: Checkbox(
                                                              value:
                                                                  allDayCheckMonday,
                                                              activeColor: color
                                                                  .AppColor
                                                                  .Font_sub
                                                                  .withOpacity(
                                                                      0.5),
                                                              checkColor:
                                                                  Colors.white,
                                                              onChanged:
                                                                  (value) =>
                                                                      setState(
                                                                          () {
                                                                        this.allDayCheckMonday =
                                                                            !(allDayCheckMonday);
                                                                        if (allDayCheckMonday ==
                                                                            false) {
                                                                        } else {
                                                                          _increaseWidth(
                                                                              0);
                                                                          _increaseHeight(
                                                                              0);
                                                                          setState(
                                                                              () {
                                                                            time_start[0] =
                                                                                TimeOfDay(hour: 0, minute: 0);
                                                                            time_end[0] =
                                                                                TimeOfDay(hour: 23, minute: 59);
                                                                          });
                                                                        }
                                                                      })),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 500),
                                        top: moveDown[0],
                                        curve: Curves.fastOutSlowIn,
                                      ),
                                      Container(
                                        //BackGround
                                        padding: const EdgeInsets.all(5),
                                        height: 60,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selected = !(selected);
                                          });
                                          if (value == false) {
                                            setState(() {
                                              value = !(value);
                                              moveDown[0] = 60;
                                              extendDown[0] = 120;
                                            });
                                          } else {
                                            setState(() {
                                              _increaseWidth(0);
                                              _increaseHeight(0);
                                            });
                                          }
                                        }, //
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          height: 60,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              // color: color.AppColor.Gradient2.withOpacity(1),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    color.AppColor.Gradient1,
                                                    color.AppColor.Gradient1
                                                        .withOpacity(0.9),
                                                    color.AppColor.Gradient2
                                                        .withOpacity(0.9),
                                                    color.AppColor.Gradient2,
                                                    //add more colors for gradient
                                                  ],
                                                  begin: Alignment
                                                      .topRight, //begin of the gradient color
                                                  end: Alignment
                                                      .bottomLeft, //end of the gradient color
                                                  stops: const [
                                                    0,
                                                    0.1,
                                                    0.9,
                                                    1
                                                  ] //st the stops number equal to numbers of color
                                                  ),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0, 5),
                                                    blurRadius: 5,
                                                    color: Colors.grey
                                                        .withOpacity(1))
                                              ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: value,
                                                  activeColor: Colors.white,
                                                  checkColor:
                                                      color.AppColor.Gradient2,
                                                  onChanged: (value) =>
                                                      setState(() {
                                                        this.value = value!;
                                                        if (value == false) {
                                                          setState(() {
                                                            moveDown[0] = 0;
                                                            extendDown[0] = 60;
                                                            allDayCheckMonday =
                                                                false;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            moveDown[0] = 60;
                                                            extendDown[0] = 120;
                                                          });
                                                        }
                                                      })),
                                              Center(
                                                child: Text(
                                                  "Monday",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 35,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedContainer(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn,
                                  height: extendDown[0],
                                  decoration: BoxDecoration(
                                    //color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ), //BorderRadius.Only
                                  ),
                                  child: Stack(
                                    children: [
                                      /* Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              margin: EdgeInsets.fromLTRB(
                                                  15, 20, 15, 0),
                                              curve: Curves.easeInOutExpo,
                                              height: _height,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.box_class
                                                    .withOpacity(0.5),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(5),
                                                  bottomRight: Radius.circular(5),
                                                ), //BorderRadius.Only
                                              ),
                                              child: Row(
                                                children: [],
                                              )),
                                          /*  AnimatedPositioned(
                                              child: Container(),
                                              duration: Duration(seconds: 2)), */
                                          SizedBox(
                                            width: 25,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectTimeStart(context);
                                            }, // Handle your callback
                                            child: Ink(
                                              height: 40,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.Font_sub,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${zeroHourCheck(time_start_picker)}:${zeroMinCheck(time_start_picker)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          Text(" to",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: color.AppColor.Font_sub,
                                                  fontWeight: FontWeight.bold)),
                                          Expanded(child: Container()),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectTimeStart(context);
                                            }, // Handle your callback
                                            child: Ink(
                                              height: 40,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: color.AppColor.Font_sub,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${zeroHourCheck(time_start_picker)}:${zeroMinCheck(time_start_picker)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                        ],
                                      ), */
                                      AnimatedPositioned(
                                        //height: 60.0,
                                        child: Container(
                                          //color: Colors.blue,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    //color: Colors.purple,
                                                    //height: 10,
                                                    //width: 10,
                                                    child: Column(
                                                      children: [
                                                        Text("Start at:",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: color
                                                                    .AppColor
                                                                    .Font_sub,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        InkWell(
                                                          onTap: () {
                                                            selectTimeStart(
                                                                context, 0);
                                                          }, // Handle your callback
                                                          child: Ink(
                                                            height: 35,
                                                            width: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: color
                                                                  .AppColor
                                                                  .Font_sub,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${zeroHourCheck(time_start[0])}:${zeroMinCheck(time_start[0])}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 17, 0, 0),
                                                    child: Text("to",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: color
                                                                .AppColor
                                                                .Font_sub,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    //color: Colors.purple,
                                                    //height: 10,
                                                    //width: 10,
                                                    child: Column(
                                                      children: [
                                                        Text("End at:",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: color
                                                                    .AppColor
                                                                    .Font_sub,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        InkWell(
                                                          onTap: () {
                                                            selectTimeEnd(
                                                                context, 0);
                                                          }, // Handle your callback
                                                          child: Ink(
                                                            height: 35,
                                                            width: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: color
                                                                  .AppColor
                                                                  .Font_sub,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${zeroHourCheck(time_end[0])}:${zeroMinCheck(time_end[0])}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(0, 5,
                                                                    0, 0),
                                                            child: Text(
                                                                "All day",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: color
                                                                        .AppColor
                                                                        .Font_sub,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                        SizedBox(
                                                          width: 30,
                                                          height: 35,
                                                          child: Checkbox(
                                                              value:
                                                                  allDayCheckMonday,
                                                              activeColor: color
                                                                  .AppColor
                                                                  .Font_sub
                                                                  .withOpacity(
                                                                      0.5),
                                                              checkColor:
                                                                  Colors.white,
                                                              onChanged:
                                                                  (value) =>
                                                                      setState(
                                                                          () {
                                                                        this.allDayCheckMonday =
                                                                            !(allDayCheckMonday);
                                                                        if (allDayCheckMonday ==
                                                                            false) {
                                                                        } else {
                                                                          _increaseWidth(
                                                                              0);
                                                                          _increaseHeight(
                                                                              0);
                                                                          setState(
                                                                              () {
                                                                            time_start[0] =
                                                                                TimeOfDay(hour: 0, minute: 0);
                                                                            time_end[0] =
                                                                                TimeOfDay(hour: 23, minute: 59);
                                                                          });
                                                                        }
                                                                      })),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 500),
                                        top: moveDown[0],
                                        curve: Curves.fastOutSlowIn,
                                      ),
                                      Container(
                                        //BackGround
                                        padding: const EdgeInsets.all(5),
                                        height: 60,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selected = !(selected);
                                          });
                                          if (value == false) {
                                            setState(() {
                                              value = !(value);
                                              moveDown[0] = 60;
                                              extendDown[0] = 120;
                                            });
                                          } else {
                                            setState(() {
                                              _increaseWidth(0);
                                              _increaseHeight(0);
                                            });
                                          }
                                        }, //
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          height: 60,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              // color: color.AppColor.Gradient2.withOpacity(1),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    color.AppColor.Gradient1,
                                                    color.AppColor.Gradient1
                                                        .withOpacity(0.9),
                                                    color.AppColor.Gradient2
                                                        .withOpacity(0.9),
                                                    color.AppColor.Gradient2,
                                                    //add more colors for gradient
                                                  ],
                                                  begin: Alignment
                                                      .topRight, //begin of the gradient color
                                                  end: Alignment
                                                      .bottomLeft, //end of the gradient color
                                                  stops: const [
                                                    0,
                                                    0.1,
                                                    0.9,
                                                    1
                                                  ] //st the stops number equal to numbers of color
                                                  ),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0, 5),
                                                    blurRadius: 5,
                                                    color: Colors.grey
                                                        .withOpacity(1))
                                              ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: value,
                                                  activeColor: Colors.white,
                                                  checkColor:
                                                      color.AppColor.Gradient2,
                                                  onChanged: (value) =>
                                                      setState(() {
                                                        this.value = value!;
                                                        if (value == false) {
                                                          setState(() {
                                                            moveDown[0] = 0;
                                                            extendDown[0] = 60;
                                                            allDayCheckMonday =
                                                                false;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            moveDown[0] = 60;
                                                            extendDown[0] = 120;
                                                          });
                                                        }
                                                      })),
                                              Center(
                                                child: Text(
                                                  "Monday",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 35,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Container(
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                              child: RaisedButton(
                                padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                onPressed: () {},
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          color.AppColor.Gradient1
                                              .withOpacity(0.9),
                                          color.AppColor.Gradient2
                                              .withOpacity(0.9),
                                        ],
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                      constraints: BoxConstraints(
                                          maxHeight: 40, maxWidth: 86),
                                      alignment: Alignment.center,
                                      child: Text("Add",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      /* Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            width: 70,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13),
                                gradient: LinearGradient(
                                    colors: [
                                      color.AppColor.Gradient1,
                                      color.AppColor.Gradient1.withOpacity(0.8),
                                      color.AppColor.Gradient2.withOpacity(0.8),
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
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 5),
                                      blurRadius: 5,
                                      color: Colors.grey.withOpacity(1))
                                ] //border corner radius
                                ),
                            child: Center(
                              child: Text("Add",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ],
                      ) */
                    ],
                  )
                ],
              ),
            ),
            /* Center(
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.alarm),
                    iconSize: 40,
                    onPressed: () {
                      selectTime(context);
                      print(time);
                    },
                  ),
                  Text(
                    'time ${zeroHourCheck(time)}:${zeroMinCheck(time).toString()}',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            ) */
          ]),
        ));
  }

  Widget buildSingleCheckbox(CheckBoxState checkbox) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: color.AppColor.Gradient1,
        value: checkbox.value,
        title: Text(
          checkbox.title,
          style: TextStyle(fontSize: 20),
        ),
        onChanged: (value) => setState(() => checkbox.value = value!),
      );

  void _increaseWidth(int day) {
    setState(() {
      moveDown[day] =
          moveDown[day] >= 60 ? moveDown[day] -= 60 : moveDown[day] += 60;
    });
  }

  void _increaseHeight(int day) {
    setState(() {
      extendDown[day] = moveDown[day] >= 60 ? 120 : 60;
    });
  }
}
