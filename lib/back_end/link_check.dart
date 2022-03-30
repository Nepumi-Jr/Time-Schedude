import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

//? Code from so's
List<String> getLinks(String input) {
  List<String> myList = [];
  final matcher = new RegExp(
      r"(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)",
      caseSensitive: false,
      multiLine: false);
  int i = 0;
  while ((matcher.hasMatch(input))) {
    String url = matcher.stringMatch(input).toString();
    myList.add(url);
    i++;
    input = input.replaceAll(url, "");
  }

  return myList;
}

Link_Check(String input) {
  int i = 0;
  int j = 0;
  List<String> myList = List<String>.filled(100, "");
  var withoutEquals;
  var app;
  String all_Linkchecked = "";
  final matcher = new RegExp(
      r"(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)",
      caseSensitive: false,
      multiLine: false); //check link in text
  myList[i] = matcher.stringMatch(input).toString(); //first link
  while ((matcher.hasMatch(input)) == true) {
    //if there have link in text
    app = Linkify(
      //check for link can launch
      onOpen: (link) async {
        if (await canLaunch(link.url)) {
          await launch(link.url);
        } else {
          throw 'Could not launch $link';
        }
      },
      text: myList[i],
      style: TextStyle(color: Colors.black),
      linkStyle: TextStyle(color: Colors.blue),
    );
    i = i + 1;
    input = input.replaceAll(matcher.stringMatch(input).toString(),
        ""); //เป็น text ที่ตัด link อันแรกแล้ว
    myList[i] =
        matcher.stringMatch(input).toString(); //link จะถูกเก็บในarray mylist

  }
  while (j != i) {
    print(j);
    all_Linkchecked = all_Linkchecked + "\n" + myList[j];
    j = j + 1;
  }
  app = Linkify(
    onOpen: (link) async {
      if (await canLaunch(link.url)) {
        await launch(link.url);
      } else {
        throw 'Could not launch $link';
      }
    },
    text: all_Linkchecked,
    style: TextStyle(color: Colors.black),
    linkStyle: TextStyle(color: Colors.blue),
  );
  return app;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My app",
      home: Scaffold(
          appBar: AppBar(
            title: Text(("www.youtube.com")),
          ),
          body: Link_Check(
              "hello this is my link lesson https://www.youtube.com/watch?v=iik25wqIuFo and https://www.youtube.com/watch?v=-aB6MQU8l1s and https://www.youtube.com/watch?v=viQPExRmxdk and ")),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}
