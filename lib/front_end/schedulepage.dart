import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendlink_application/back_end/time_sub.dart';
import 'package:sendlink_application/back_end/time_table.dart';
import 'package:sendlink_application/front_end/addpage.dart';
import 'package:tuple/tuple.dart';
import 'colors.dart' as color;

class schedule extends StatefulWidget {
  const schedule({Key? key}) : super(key: key);

  @override
  _scheduleState createState() => _scheduleState();
}

class _scheduleState extends State<schedule> {
  List<String> dayInWeek = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  List<Widget> classOfDay(int day) {
    List<Tuple2<String, TimeSub>> dayClass =
        TimeTable.getSubjectAtDay(dayInWeek[day]);
    if (dayClass.length == 0) {
      return [];
    }
    List<Widget> data = [];
    for (var i = 0; i < dayClass.length; i++) {
      data.add(
        InkWell(
          onTap: () {
            print("contain tap!!");
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(bottom: 4),
            height: 50,
            width: MediaQuery.of(context).size.width * 5.45 / 6.8,
            decoration: BoxDecoration(
                color: color.AppColor.box_class,
                borderRadius: BorderRadius.circular(10),
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
                          dayClass[i].item1,
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
                          zeroCheck(dayClass[i].item2.hourStart) +
                              ":" +
                              zeroCheck(dayClass[i].item2.minuteStart) +
                              " - " +
                              zeroCheck(dayClass[i].item2.hourEnd) +
                              ":" +
                              zeroCheck(dayClass[i].item2.minuteEnd) +
                              "",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.normal),
                        )
                      ],
                    )
                  ],
                ),
                Expanded(child: Container()),
                InkWell(
                  onTap: () {
                    print("edit tap!!");
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 4, 10, 4),
                    width: 50,
                    height: 35,
                    decoration: BoxDecoration(
                        color: color.AppColor.offline,
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                            colors: [
                              color.AppColor.Gradient1,
                              color.AppColor.Gradient1.withOpacity(0.8),
                              color.AppColor.Gradient2.withOpacity(0.8),
                              color.AppColor.Gradient2,
                            ],
                            begin: Alignment
                                .topRight, //begin of the gradient color
                            end: Alignment
                                .bottomLeft, //end of the gradient color
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
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      );
    }
    return data;
  }

  List<Widget> getClassForOneDay() {
    List<Widget> data = [];
    for (var i = 0; i < 7; i++) {
      print(TimeTable.getSubjectAtDay(dayInWeek[i]));
      if (classOfDay(i).length != 0) {
        data.add(Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 5, 3),
                child: Text(
                  "${dayInWeek[i]}",
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
              ),
              Column(children: classOfDay(i)),
              SizedBox(
                height: 5,
              )
            ],
          ),
        ));
      }
    }
    return data;
  }

  goAddPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Addpage()),
    );
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
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
                  IconData(0xf537, fontFamily: 'MaterialIcons'),
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onPressed: () => goAddPage(),
        ),
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
              padding: EdgeInsets.fromLTRB(0, 6, 0, 5),
              margin: EdgeInsets.fromLTRB(25, 0, 25, 5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: color.AppColor.WidgetBackground.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15), //border corner radius
              ),
              alignment: Alignment.center,
              //? CODE LIST FUNCTION HERE BITCHES!!
              child: Column(
                children: getClassForOneDay(),
              ),
              /* child: Column(
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
                      //color: color.AppColor.box_class.withOpacity(0.5),
                      color: Colors.red,
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
                  /* Row(
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
                  ) */
                ],
              ),
             */
            ),
          ]),
        ));
  }
}
