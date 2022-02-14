import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart' as color;

class schedule extends StatefulWidget {
  const schedule({Key? key}) : super(key: key);

  @override
  _scheduleState createState() => _scheduleState();
}

class _scheduleState extends State<schedule> {
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
                  "Class Schedule",
                  style: TextStyle(
                      fontSize: 20,
                      color: color.AppColor.NameWidget,
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
              width: double.infinity,
              decoration: BoxDecoration(
                color: color.AppColor.WidgetBackground.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20), //border corner radius
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(children: [
                    SizedBox(width: 10),
                    Text("Monday",
                        style: TextStyle(
                            fontSize: 18,
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
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Circuit Signal System",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Text("9:00 - 12:00 PM",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: color.AppColor.Font_sub)),
                              ],
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                          width: 50,
                          height: 30,
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
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 5),
                                    blurRadius: 5,
                                    color: Colors.grey.withOpacity(1))
                              ]),
                          child: Center(
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 15, 5),
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
                              width: 2.5,
                            ),
                            Icon(
                              IconData(0xf537, fontFamily: 'MaterialIcons'),
                              size: 30,
                              color: Colors.white,
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
}
