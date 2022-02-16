import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendlink_application/back_end/Timetable.dart';
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
  late TimeOfDay picked;

  late String subject;

  bool value = false;

  List<CheckBoxState> dayInWeek = [];

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

  Future<File> _incrementCounter() {
    setState(() {
      subject = TimeTable.timetable.toString();
    });

    // Write the variable as a string to the file.
    return Storage.writeSubject(subject);
  }

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
                  width: 35,
                  height: 35,
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
                  padding: const EdgeInsets.only(left: 1),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 3.5,
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
                  SizedBox(height: 5),
                  SizedBox(height: 2),
                  Row(children: [
                    SizedBox(width: 10),
                    Text("Date Class:",
                        style: TextStyle(
                            fontSize: 20,
                            color: color.AppColor.Font_sub,
                            fontWeight: FontWeight.bold)),
                  ]),
                  SizedBox(height: 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //...dayInWeek.map(buildSingleCheckbox).toList(),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    child: RaisedButton(
                      onPressed: () => {print(555)},
                      child: Text('Submit'),
                      //other properties
                    ),
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
}
