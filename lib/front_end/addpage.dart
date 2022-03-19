import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendlink_application/back_end/time_sub.dart';
import 'package:sendlink_application/back_end/time_table.dart';
import 'package:sendlink_application/back_end/storage.dart';
import 'package:sendlink_application/back_end/subject.dart';
import 'package:sendlink_application/front_end/checkbox_state.dart';
import 'package:sendlink_application/front_end/homepage.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
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

  List<bool> dayCheck = [false, false, false, false, false, false, false];

  List<bool> allDayCheck = [false, false, false, false, false, false, false];

  late TimeOfDay picked;

  late String subject;

  List<bool> value = [false, false, false, false, false, false, false];

  List<String> dayInWeek = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  double _height = 60;
  double _width = 100;
  List<bool> selected = [false, false, false, false, false, false, false];

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

  getInformationToClassTimeTable() {
    Subject ter;
    List<TimeSub> allTimeLearn = [];

    for (var i = 0; i < dayCheck.length; i++) {
      if (dayCheck[i]) {
        allTimeLearn.add(TimeSub(IntDaytoString(i), time_start[i].hour,
            time_start[i].minute, time_end[i].hour, time_end[i].minute));
      }
    }
    ter = Subject(_subject_name.text.toString(), _link.text.toString(),
        _place_name.text.toString(), allTimeLearn);
    TimeTable.addSubject(ter);
    print(TimeTable.listSubject.toList());
  }

  IntDaytoString(int dayOfWeek) {
    if (dayOfWeek == 0) {
      return 'Monday';
    } else if (dayOfWeek == 1) {
      return 'Tuesday';
    } else if (dayOfWeek == 2) {
      return 'Wednesday';
    } else if (dayOfWeek == 3) {
      return 'ThursDay';
    } else if (dayOfWeek == 4) {
      return 'Friday';
    } else if (dayOfWeek == 5) {
      return 'Saturday';
    } else if (dayOfWeek == 6) {
      return 'Sunday';
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Is the information complete or not?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                getInformationToClassTimeTable();
                /* AwesomeDialog(
                  context: context,
                  animType: AnimType.LEFTSLIDE,
                  headerAnimationLoop: false,
                  dialogType: DialogType.SUCCES,
                  showCloseIcon: true,
                  title: 'Succes',
                  desc:
                      'Dialog description here..................................................',
                )..show(); */
              },
            ),
          ],
        );
      },
    );
  }

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

  back() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 35),
          child: Column(children: [
            Container(
              //color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
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
                  ),
                ],
              ),
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
                  "Add your class.",
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
                        controller: _link,
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
                              children: GetDayInWeek(),
                            ),
                          )),
                      Container(
                        //color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                _showMyDialog();
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                width: 70,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: color.AppColor.Gradient2,
                                    borderRadius: BorderRadius.circular(8),
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
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 5),
                                          blurRadius: 5,
                                          color: Colors.grey.withOpacity(1))
                                    ]),
                                child: Center(
                                    child: Text("Add",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ]),
        ));
  }

  List<Widget> GetDayInWeek() {
    List<Widget> data = [];
    for (var day = 0; day < 7; day++) {
      data.add(
        AnimatedContainer(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          height: extendDown[day],
          decoration: BoxDecoration(
            //color: Colors.red,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ), //BorderRadius.Only
          ),
          child: Stack(
            children: [
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
                                        color: color.AppColor.Font_sub,
                                        fontWeight: FontWeight.bold)),
                                InkWell(
                                  onTap: () {
                                    selectTimeStart(context, day);
                                  }, // Handle your callback
                                  child: Ink(
                                    height: 35,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: color.AppColor.Font_sub,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${zeroHourCheck(time_start[day])}:${zeroMinCheck(time_start[day])}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
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
                            margin: EdgeInsets.fromLTRB(0, 17, 0, 0),
                            child: Text("to",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: color.AppColor.Font_sub,
                                    fontWeight: FontWeight.bold)),
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
                                        color: color.AppColor.Font_sub,
                                        fontWeight: FontWeight.bold)),
                                InkWell(
                                  onTap: () {
                                    selectTimeEnd(context, day);
                                  }, // Handle your callback
                                  child: Ink(
                                    height: 35,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: color.AppColor.Font_sub,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${zeroHourCheck(time_end[day])}:${zeroMinCheck(time_end[day])}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
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
                                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Text("All day",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: color.AppColor.Font_sub,
                                            fontWeight: FontWeight.bold))),
                                SizedBox(
                                  width: 30,
                                  height: 35,
                                  child: Checkbox(
                                      value: allDayCheck[day],
                                      activeColor: color.AppColor.Font_sub
                                          .withOpacity(0.5),
                                      checkColor: Colors.white,
                                      onChanged: (value) => setState(() {
                                            this.allDayCheck[day] =
                                                !(allDayCheck[day]);
                                            if (allDayCheck[day] == false) {
                                            } else {
                                              _increaseWidth(day);
                                              _increaseHeight(day);
                                              setState(() {
                                                time_start[day] = TimeOfDay(
                                                    hour: 0, minute: 0);
                                                time_end[day] = TimeOfDay(
                                                    hour: 23, minute: 59);
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
                top: moveDown[day],
                curve: Curves.fastOutSlowIn,
              ),
              Container(
                //BackGround
                padding: const EdgeInsets.all(5),
                height: 60,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selected[day] = !(selected[day]);
                  });
                  if (value[day] == false) {
                    setState(() {
                      value[day] = !(value[day]);
                      moveDown[day] = 60;
                      extendDown[day] = 120;
                    });
                  } else {
                    setState(() {
                      _increaseWidth(day);
                      _increaseHeight(day);
                    });
                  }
                }, //
                child: Container(
                  padding: const EdgeInsets.all(5),
                  height: 60,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      // color: color.AppColor.Gradient2.withOpacity(1),
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          colors: [
                            color.AppColor.Gradient1,
                            color.AppColor.Gradient1.withOpacity(0.9),
                            color.AppColor.Gradient2.withOpacity(0.9),
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
                          ] //st the stops number equal to numbers of color
                          ),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 5,
                            color: Colors.grey.withOpacity(1))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: value[day],
                          activeColor: Colors.transparent,
                          checkColor: Colors.white,
                          onChanged: (value) => setState(() {
                                this.value[day] = value!;
                                if (value == false) {
                                  setState(() {
                                    moveDown[day] = 0;
                                    extendDown[day] = 60;
                                    allDayCheck[day] = false;
                                  });
                                } else {
                                  setState(() {
                                    moveDown[day] = 60;
                                    extendDown[day] = 120;
                                  });
                                }
                              })),
                      Center(
                        child: Text(
                          dayInWeek[day],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
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
      );
    }
    return data;
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
