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
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //time for clock
  late DateTime ter;
  String timenow = "";
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        ter = DateTime.now();
        String datetime1 = DateFormat("HH:mm").format(ter);
        timenow = "${datetime1}";
      });
    });
  }

  /* @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          child: Column(
            
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(20, 45, 20, 20),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.blueAccent,
                          Colors.purpleAccent,
                          Colors.purple
                          //add more colors for gradient
                        ],
                        begin: Alignment.topRight, //begin of the gradient color
                        end: Alignment.bottomLeft, //end of the gradient color
                        stops: [0, 0, 0.6, 1] //stops for individual color
                        //set the stops number equal to numbers of color
                        ),
                    borderRadius:
                        BorderRadius.circular(30), //border corner radius
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    timenow,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 79,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 6.0),
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      );
}  */

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Time-Schedule",
                    style: TextStyle(
                        fontSize: 30,
                        color: color.AppColor.NamePage,
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Icon(
                    Icons.backup_table,
                    color: Colors.black87,
                    size: 30.0,
                  )
                  //Icon(Icon.arrow)
                ],
              ),
              SizedBox(height: 30),
              /* Row(
                children: [
                  Text(
                    "Time",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ) */
            ],
          ),
        ),
      );
}
