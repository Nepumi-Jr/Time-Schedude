import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'colors.dart' as color;

class settingpage extends StatefulWidget {
  const settingpage({Key? key}) : super(key: key);

  @override
  _settingpageState createState() => _settingpageState();
}

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
                      Container(
                        width: 34,
                        height: 26,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(5), //border corner radius
                        ),
                      ),
                      SizedBox(width: 5),
                      Text("hr."),
                      SizedBox(width: 5),
                      Container(
                        width: 34,
                        height: 26,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(5), //border corner radius
                        ),
                      ),
                      SizedBox(width: 5),
                      Text("min."),
                      SizedBox(width: 25),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
