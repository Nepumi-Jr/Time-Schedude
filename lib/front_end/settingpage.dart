import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sendlink_application/back_end/Reminder.dart';
import 'colors.dart' as color;

class settingpage extends StatefulWidget {
  const settingpage({Key? key}) : super(key: key);

  @override
  _settingpageState createState() => _settingpageState();
}

//dropdown STRING.
String dropdownValue = 'English';
bool toggleValue = true;
int Min = 30;

class _settingpageState extends State<settingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(top: 35),
        child: Column(
          children: [
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

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                SizedBox(
                  width: 45,
                ),
                Text(
                  "Notification Setting",
                  style: TextStyle(
                      fontSize: 20,
                      color: color.AppColor.NameWidget,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            // * * Container for other information
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
              margin: EdgeInsets.fromLTRB(25, 0, 25, 5),
              width: double.infinity,
              height: 527,
              decoration: BoxDecoration(
                color: color.AppColor.WidgetBackground.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20), //border corner radius
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text("Notification",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                      //switch**************************
                      Expanded(child: Container()),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: 65,
                        height: 35,
                        decoration: BoxDecoration(
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
                          borderRadius: BorderRadius.circular(20),
                          color: toggleValue
                              ? Colors.greenAccent
                              : color.AppColor.background_textfield
                                  .withOpacity(0.1),
                        ),
                        child: Stack(
                          children: <Widget>[
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                              top: 1.5,
                              left: toggleValue ? 25 : 0,
                              right: toggleValue ? 0 : 25,
                              child: InkWell(
                                onTap: toggleButtons,
                                child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      return RotationTransition(
                                          child: child, turns: animation);
                                    },
                                    child: toggleValue
                                        ? Icon(Icons.circle,
                                            color: Colors.white,
                                            size: 33,
                                            key: UniqueKey())
                                        : Icon(
                                            Icons.circle,
                                            color: Colors.white,
                                            size: 33,
                                            key: UniqueKey(),
                                          )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text("Daily Notification",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                      Expanded(child: Container()),
                      Icon(
                        IconData(0xf5fe, fontFamily: 'MaterialIcons'),
                        color: Colors.black,
                        size: 25,
                      ),
                      SizedBox(width: 27),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text("Class Notification",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                      Expanded(child: Container()),
                      Icon(
                        IconData(0xe23e,
                            fontFamily: 'MaterialIcons'), //icon event
                        color: Colors.black,
                        size: 28,
                      ),
                      SizedBox(width: 25),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text("Alam Clock",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                      Expanded(child: Container()),
                      SizedBox(width: 5),
                      Container(
                        width: 50,
                        height: 26,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(5), //border corner radius
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 1,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 13,
                                ),
                                Text(
                                  "$Min",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "min.",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 25),
                    ],
                  ),
                  Row(children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text("//alarm before class start.",
                        style: TextStyle(
                            fontSize: 12,
                            color: color.AppColor.Font_sub,
                            fontWeight: FontWeight.w600))
                  ]),
                  SizedBox(
                    height: 6,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Language",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Expanded(child: Container()),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['English', 'Thai']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ]),
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                          width: 110,
                          height: 31,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 5),
                                    blurRadius: 5,
                                    color: Colors.grey.withOpacity(1))
                              ]),
                          padding: EdgeInsets.only(top: 3),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 34.5,
                                  ),
                                  Text("reset",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text("//reset application.",
                          style: TextStyle(
                              fontSize: 12,
                              color: color.AppColor.Font_sub,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        width: 90,
                        height: 35,
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
                        child: Column(
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 19,
                                ),
                                Text("Apply",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700)),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        width: 90,
                        height: 35,
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
                        child: Column(
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 22,
                                ),
                                Text("Done",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700)),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  toggleButtons() {
    Reminder remObj = Reminder();
    remObj.init();
    setState(() {
      toggleValue = !toggleValue;
      remObj.setNotification = toggleValue;
    });
  }
}
