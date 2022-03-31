import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:sendlink_application/front_end/settingpage.dart';
import 'package:sendlink_application/front_end/editpage.dart';
import 'package:sendlink_application/front_end/settingpage.dart';

import 'front_end/addpage.dart';
import 'front_end/homepage.dart';
import 'front_end/schedulepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Link',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      //home: const settingpage(),
      /* home: const EditPage(
          subject_name: "3456",
          link: "https://www.facebook.com/",
          place: "My home."),
      //home: HomePage(), */
    );
  }
}
