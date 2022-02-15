import 'dart:async';
import 'dart:io';
import 'Timetable.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'storage.dart';
import 'subject.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      home: FlutterDemo(storage: Storage()),
    ),
  );
}

class FlutterDemo extends StatefulWidget {
  const FlutterDemo({Key? key, required this.storage}) : super(key: key);

  final Storage storage;

  @override
  _FlutterDemoState createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  String _counter = 'aaaa';

  @override
  void initState() {
    super.initState();

    Storage.readSubject().then((String value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _incrementCounter() {
    setState(() {
      /*TimeTable.addSubject(
          Subject.addSubject('math', 'www.youtube.com', 'online', [
        [4, 8, 0, 20, 0],
        [2, 14, 30, 17, 30]
      ]));*/
      _counter = TimeTable.listSubject[0].link;
    });

    // Write the variable as a string to the file.
    return Storage.writeSubject(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading and Writing Files'),
      ),
      body: Center(
        child: Text(
          'Button tapped $_counter time',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
