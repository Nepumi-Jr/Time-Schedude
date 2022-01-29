import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sendlink_application/front_end/subject.dart';
import 'colors.dart' as color;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

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

  late File jsonFile;
  late Directory dir;
  String fileName = "subject_info.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent = {};

  String class_name = "";

  Map<String, dynamic> class_info = {};

  get subjectClass => null;

  Future<void> readTextFile() async {
    String fileContent = 'Cheetah Coding';

    jsonFile = new File(dir.path + "/" + fileName);
    class_info.addAll(json.decode(jsonFile.readAsStringSync()));
    print(class_info.toString());

    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      File filePath = new File(dir.path + "/subject_info.json");
      bool fileExists = filePath.existsSync();

      if (fileExists) {
        // read file
        print('read json file');
        String jsonData = filePath.readAsStringSync();
        print(jsonData);
        /* var parsed = jsonDecode(jsonData);
        setState(() {
          var jsonResult = parsed
              .map<subjectClass>((json) => subjectClass.fromJsonFile(json))
              .toList();
        }); */
      } else {
        print('File Not Found');
      }
    });

    /* 
    File file = await jsonFile;

    if (await file.exists()) {
      try {
        class_name += await file.readAsString();
        return json.decode(fileContent);
      } catch (e) {
        print(e);
      }
    } */
  }

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

    print("กูยังทำงานอยู่1");

    /*
     FIle MANAGER
    */

    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      print("กูยังทำงานอยู่2");
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(
            () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });

    print("กูยังทำงานอยู่3");
    //readTextFile();
  }

  void createFile(
      Map<String, dynamic> content, Directory dir, String fileName) {
    print("Creating file!");
    File file = new File(dir.path + "/" + fileName);
    print(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(String key, dynamic value) {
    print("Writing to file!");
    Map<String, dynamic> content = {key: value};
    if (fileExists) {
      print("File exists");
      print(dir.path + "/" + fileName);
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile(content, dir, fileName);
    }
    this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    print(fileContent);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
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
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: IconButton(
                          icon: Icon(
                            IconData(0xf694, fontFamily: 'MaterialIcons'),
                          ),
                          iconSize: 20,
                          color: Colors.white,
                          splashColor: Colors.white.withOpacity(0.2),
                          onPressed: () {
                            readTextFile();
                          },
                        ),
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
                  borderRadius:
                      BorderRadius.circular(20), //border corner radius
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
                            "Finished",
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
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              height: 50,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: color.AppColor.box_class,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 5),
                                        blurRadius: 5,
                                        color: Colors.grey.withOpacity(0.8))
                                  ]),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            fileContent.toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            "9:00 - 10:30 AM",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    width: 50,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: color.AppColor.offline,
                                        borderRadius: BorderRadius.circular(10),
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
                      )
                    ],
                  ),
                )),
            Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color.AppColor.WidgetBackground.withOpacity(0.5),
                  borderRadius:
                      BorderRadius.circular(20), //border corner radius
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
                            "During",
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
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              height: 50,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: color.AppColor.box_class,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 5),
                                        blurRadius: 5,
                                        color: Colors.grey.withOpacity(0.8))
                                  ]),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Digital Logic Design",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            "9:00 - 10:30 AM",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    width: 50,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              color.AppColor.Gradient3,
                                              color.AppColor.Gradient3
                                                  .withOpacity(0.8),
                                              color.AppColor.Gradient4
                                                  .withOpacity(0.8),
                                              color.AppColor.Gradient4,
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
                                        color: color.AppColor.offline,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 5),
                                              blurRadius: 5,
                                              color:
                                                  Colors.grey.withOpacity(1)),
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
                      )
                    ],
                  ),
                )),
            Container(
              margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: color.AppColor.WidgetBackground.withOpacity(0.5),
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
                          "Up Next",
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
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            height: 50,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: color.AppColor.box_class,
                                borderRadius: BorderRadius.circular(15),
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
                                          "Digital Logic Design",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "9:00 - 10:30 AM",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Expanded(child: Container()),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  width: 50,
                                  height: 30,
                                  decoration: BoxDecoration(
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
                                      color: color.AppColor.offline,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 5),
                                            blurRadius: 5,
                                            color: Colors.grey.withOpacity(1)),
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
                    )
                  ],
                ),
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
                          "List to do",
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
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: color.AppColor.box_class,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 5),
                                      blurRadius: 5,
                                      color: Colors.grey.withOpacity(0.8))
                                ]),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      IconData(
                                        0xe047,
                                        fontFamily: 'MaterialIcons',
                                      ),
                                      size: 24,
                                      color: color.AppColor.NameWidget,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 5, 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Add work",
                                            style: TextStyle(
                                                color:
                                                    color.AppColor.NameWidget),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Divider(
                                    //height: 20,
                                    thickness: 1,
                                    color: color.AppColor.NameWidget),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Icon(
                                      IconData(0xe158,
                                          fontFamily: 'MaterialIcons'),
                                      color: color.AppColor.Gradient1,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Differential Equation",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "work",
                                            style: TextStyle(
                                                fontSize: 10, height: 0.7),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                    //height: 20,
                                    thickness: 1,
                                    color: color.AppColor.NameWidget),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Icon(
                                      IconData(0xe098,
                                          fontFamily: 'MaterialIcons'),
                                      color: color.AppColor.Gradient1,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Done",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Divider(
                                    //height: 20,
                                    thickness: 1,
                                    color: color.AppColor.NameWidget),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      );
}
