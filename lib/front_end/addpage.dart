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

  late TimeOfDay time_start_picker;
  late TimeOfDay time_end_picker;
  late TimeOfDay time_start_Sunday;
  late TimeOfDay time_end_Sunday;
  late TimeOfDay time_start_Monday;
  late TimeOfDay time_end_Monday;
  late TimeOfDay time_start_Tuesday;
  late TimeOfDay time_end_Tuesday;
  late TimeOfDay time_start_Wednesday;
  late TimeOfDay time_end_Wednesday;
  late TimeOfDay time_start_Thursday;
  late TimeOfDay time_end_Thursday;
  late TimeOfDay time_start_Friday;
  late TimeOfDay time_end_Friday;
  late TimeOfDay time_start_Saturday;
  late TimeOfDay time_end_Saturday;

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
  double moveDown = 0.0;
  bool selected = false;

  double extendDown = 60;

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
    time_start_picker = TimeOfDay.now();
    time_end_picker = TimeOfDay.now();
  }

  /* Future<File> _incrementCounter() {
    setState(() {
      subject = TimeTable.timetable.toString();
    });

    // Write the variable as a string to the file.
    return Storage.writeSubject(subject);
  } */

  Future<Null> selectTimeStart(BuildContext context) async {
    picked = (await showTimePicker(
        context: context, initialTime: time_start_picker))!;

    if (picked != null) {
      setState(() {
        time_start_picker = picked;
      });
    }
  }

  Future<Null> selectTimeEnd(BuildContext context) async {
    picked =
        (await showTimePicker(context: context, initialTime: time_end_picker))!;

    if (picked != null) {
      setState(() {
        time_end_picker = picked;
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
                          stops: [0, 0.1, 0.9, 1] //stops for individual color
                          //set the stops number equal to numbers of color
                          ),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 5,
                            color: Colors.grey.withOpacity(1))
                      ]),
                  child: Row(
                    children: [
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
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn,
                                  height: extendDown,
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
                                                                context);
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
                                                                '${zeroHourCheck(time_start_picker)}:${zeroMinCheck(time_start_picker)}',
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
                                                            selectTimeStart(
                                                                context);
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
                                                                '${zeroHourCheck(time_start_picker)}:${zeroMinCheck(time_start_picker)}',
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
                                                                  allDayCheckSunday,
                                                              activeColor:
                                                                  Colors.white,
                                                              checkColor: color
                                                                  .AppColor
                                                                  .Gradient2,
                                                              onChanged:
                                                                  (value) =>
                                                                      setState(
                                                                          () {
                                                                        this.allDayCheckSunday =
                                                                            !(allDayCheckSunday);
                                                                        if (allDayCheckSunday ==
                                                                            false) {
                                                                        } else {
                                                                          _increaseWidth();
                                                                          _increaseHeight();
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
                                        duration: Duration(seconds: 1),
                                        top: moveDown,
                                        curve: Curves.fastOutSlowIn,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selected = !(selected);
                                          });
                                          if (value == false) {
                                            setState(() {
                                              value = !(value);
                                              moveDown = 60;
                                              extendDown = 120;
                                            });
                                          } else {
                                            setState(() {
                                              _increaseWidth();
                                              _increaseHeight();
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
                                                      .withOpacity(1),
                                                  color.AppColor.Gradient2
                                                      .withOpacity(1),
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
                                                ] //st the stops number equal to numbers of color
                                                ),
                                            /* boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0, 5),
                                                    blurRadius: 5,
                                                    color: Colors.grey
                                                        .withOpacity(1))
                                              ] */
                                          ),
                                          child: Row(
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
                                                            moveDown = 0;
                                                            extendDown = 60;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            moveDown = 60;
                                                            extendDown = 120;
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

  void _increaseWidth() {
    setState(() {
      moveDown = moveDown >= 60 ? moveDown -= 60 : moveDown += 60;
    });
  }

  void _increaseHeight() {
    setState(() {
      extendDown = moveDown >= 60 ? 120 : 60;
    });
  }
}
