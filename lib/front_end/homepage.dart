import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'colors.dart' as color;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //time for clock
  late DateTime time_with_no_format, ampm, day_month_no_format;
  String timenow = "", ampm_now = "", day_month = "";
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        time_with_no_format = DateTime.now();
        ampm = DateTime.now();
        day_month_no_format = DateTime.now();
        String datetime1 = DateFormat("HH:mm").format(time_with_no_format);
        String datetime2 = DateFormat("a").format(ampm);
        String datetime3 =
            DateFormat("EEEEEE, MMM dd").format(day_month_no_format);
        timenow = "${datetime1}";
        ampm_now = "${datetime2}";
        day_month = "${datetime3}";
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
          child: Column(children: [
            /*  Row(
              children: [
                Text(
                  "Time-Schedule",
                  style: TextStyle(
                      fontSize: 30,
                      color: color.AppColor.NamePage.withOpacity(0.8),
                      fontWeight: FontWeight.w700),
                ),
                Expanded(
                  child: Container(),
                ),
                Icon(
                  Icons.backup_table,
                  color: color.AppColor.NamePage.withOpacity(0.8),
                  size: 30.0,
                )
                //Icon(Icon.arrow)
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  height: 10,
                  width: 25,
                ),
                Text(
                  "Time",
                  style: TextStyle(
                    fontSize: 20,
                    color: color.AppColor.Font_sub.withOpacity(0.8),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1), */
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
                      Icon(
                        IconData(
                          0xf694,
                          fontFamily: 'MaterialIcons',
                        ),
                        color: Colors.white,
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
                borderRadius: BorderRadius.circular(20), //border corner radius
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 5),
                        child: Text('Finished'),
                      ),
                    ],
                  ),
                  Container(
                      height: 100,
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: color.AppColor.box_class,
                        borderRadius: BorderRadius.circular(15),
                      ))
                ],
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
            )
          ]),
        ),
      );
}
