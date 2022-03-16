import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/link.dart';

import 'colors.dart' as color;
import 'package:flutter/cupertino.dart';
import 'package:sendlink_application/back_end/time_sub.dart';

class ListClassSchedule extends StatelessWidget {
  final Tuple2<String, TimeSub> subject_during;
  final List<Tuple2<String, TimeSub>> subject_upnext;
  final List<Tuple2<String, TimeSub>> subject_done;
  const ListClassSchedule(
      this.subject_during, this.subject_upnext, this.subject_done);

  zeroCheck(int time) {
    if (time == 0) {
      return "00";
    } else if (time < 10) {
      return "0" + time.toString();
    } else {
      return time.toString();
    }
  }

  List<Color> duringColor() {
    return [
      color.AppColor.Gradient3,
      color.AppColor.Gradient3.withOpacity(0.8),
      color.AppColor.Gradient4.withOpacity(0.8),
      color.AppColor.Gradient4,
    ];
  }

  List<Color> upNextColor() {
    return [
      color.AppColor.Gradient1,
      color.AppColor.Gradient1.withOpacity(0.8),
      color.AppColor.Gradient2.withOpacity(0.8),
      color.AppColor.Gradient2,
    ];
  }

  List<Color> doneColor() {
    return [
      color.AppColor.Gradient6,
      color.AppColor.Gradient6.withOpacity(0.8),
      color.AppColor.Gradient6.withOpacity(0.8),
      color.AppColor.Gradient5,
    ];
  }

  List<Widget> getClassInDayInTime(int order) {
    List<Widget> data = [];
    List<Tuple2<String, TimeSub>> listOfClass = [];
    List<Color> colorOfJoinButton;
    int numberOfLoop = 1;
    if (order == 0) {
      if (subject_during.item2.hourStart == 0 &&
          subject_during.item2.minuteStart == 0 &&
          subject_during.item2.hourEnd == 0 &&
          subject_during.item2.minuteEnd == 0 &&
          subject_during.item1 == '-') {
        return data;
      }
      numberOfLoop = 1;
      listOfClass.add(subject_during);
      colorOfJoinButton = duringColor();
    } else if (order == 1) {
      if (subject_upnext.length == 0) {
        return data;
      }
      numberOfLoop = subject_upnext.length;
      listOfClass.addAll(subject_upnext);
      colorOfJoinButton = upNextColor();
    } else {
      if (subject_done.length == 0) {
        return data;
      }
      numberOfLoop = subject_done.length;
      listOfClass.addAll(subject_done);
      colorOfJoinButton = doneColor();
    }

    for (var i = 0; i < numberOfLoop; i++) {
      print("number of loop is:" + numberOfLoop.toString());
      data.add(Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: 50,
              width: double.infinity,
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
                            listOfClass[i].item1,
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
                            zeroCheck(listOfClass[i].item2.hourStart) +
                                ":" +
                                zeroCheck(listOfClass[i].item2.minuteStart) +
                                " - " +
                                zeroCheck(listOfClass[i].item2.hourEnd) +
                                ":" +
                                zeroCheck(listOfClass[i].item2.minuteEnd) +
                                "",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          )
                        ],
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                  Link(
                    target: LinkTarget.self,
                    uri: Uri.parse('https://flutter.dev'),
                    builder: (content, followLink) => InkWell(
                      onTap: followLink,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 4, 10, 4),
                        width: 50,
                        height: 35,
                        decoration: BoxDecoration(
                            color: color.AppColor.offline,
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                                colors: colorOfJoinButton,
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
                          child: Text(
                            "Join",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
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
            SizedBox(
              height: 5,
            )
          ],
        ),
      ));
    }
    return data;
  }

  List<Widget> getAllClassSchedule(int order) {
    String class_name;
    if (order == 0) {
      if (subject_during.item2.hourStart == 0 &&
          subject_during.item2.minuteStart == 0 &&
          subject_during.item2.hourEnd == 0 &&
          subject_during.item2.minuteEnd == 0 &&
          subject_during.item1 == '-') {
        return [];
      }
      class_name = "During";
    } else if (order == 1) {
      if (subject_upnext.length == 0) {
        return [];
      }
      class_name = "Up Next";
    } else {
      if (subject_done.length == 0) {
        return [];
      }
      class_name = "Finished";
    }
    List<Widget> bigBox = [];
    bigBox.add(Container(
        width: 350,
        margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
        decoration: BoxDecoration(
          color: color.AppColor.WidgetBackground.withOpacity(0.7),
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
                    class_name,
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
              Column(
                children: getClassInDayInTime(order),
              )
            ],
          ),
        )));

    return bigBox;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
      child: Column(
        children: [
          Row(children: getAllClassSchedule(0)),
          Row(children: getAllClassSchedule(1)),
          Row(children: getAllClassSchedule(2)),
        ],
      ),
    );
  }
}
