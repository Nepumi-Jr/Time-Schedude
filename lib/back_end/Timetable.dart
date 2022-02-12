import 'subject.dart';
import 'dart:convert';
import 'time.dart';
import 'dart:io';
//import 'package:path_provider/path_provider.dart';

class TimeTable {
  static List<Subject> listSubject = [];
  static List<String> timetable = [];
  static List<String> timetable2 = [];
  static List<List<String>> timeSubject = [];
  static late String nameEditSubject;
  static late String nameSubjectDelete;
  static late int numSubjectDelete;
  static late int numListSubjectDelete;

  static void saveSubject() {
    var file = File('dataSubject.json');
    var sink = file.openWrite();
    sink.write(timetable);

    // Close the IOSink to free system resources.
    sink.close();
  }

  static void loadSubject() {
    File('dataSubject.json').readAsString().then((String contents) {
      String test = contents.substring(1);
      List<String> result = test.split(', ');
      Map valueMap = jsonDecode(result[0]);
      timetable2.add(result[0]);
      //print(valueMap['name']);
      //var user2 = Subject.fromJson(jsonDecode(TimeTable.timetable2[0]));
      //var user = Subject.fromJson(jsonDecode(TimeTable.timetable[0]));
      print(timetable2);
      var user2 = Subject.fromJson(jsonDecode(TimeTable.timetable2[0]));
      print(user2.name);
    });
  }

  void insertSubject() {}

  /*static void splitTime(Subject subject) {
    var listTimeStart = subject.timeStart.split('.');
    var listTimeEnd = subject.timeEnd.split('.');

    var hourStart = int.parse(listTimeStart[0]);
    var minuteStart = int.parse(listTimeStart[1]);
    var hourEnd = int.parse(listTimeEnd[0]);
    var minuteEnd = int.parse(listTimeEnd[1]);

    Time.forSubject(subject.date, hourStart, minuteStart, hourEnd, minuteEnd);
  }*/

  static void addSubject(Subject subject) {
    listSubject.add(subject);

    timetable.add(jsonEncode(subject.toJson()));
    //timeSubject.add([subject.timeStart, subject.timeEnd]);

    //splitTime(subject);

    saveSubject();
  }

  static void deleteSubject(Subject subject) {
    nameSubjectDelete = subject.getname;
    List<String> timeLearn = [];
    //timeLearn.add(subject.timeStart);
    //timeLearn.add(subject.timeEnd);

    for (int i = 0; i < listSubject.length; i++) {
      var nameSubject = Subject.fromJson(jsonDecode(timetable[i]));
      if (nameSubjectDelete == nameSubject.name) {
        if (timeLearn.join(",") == timeSubject[i].join(",")) {
          numListSubjectDelete = i;
        }
      }
    }

    for (int i = 0; i < timetable.length; i++) {
      var nameSubject = Subject.fromJson(jsonDecode(timetable[i]));
      if (nameSubjectDelete == nameSubject.name) {
        if (timeLearn.join(",") == timeSubject[i].join(",")) {
          numSubjectDelete = i;
        }
      }
    }

    timetable.removeAt(numSubjectDelete);
    listSubject.removeAt(numListSubjectDelete);
  }

  static void editSubject(Subject subject) {
    // click edit then check if click trashcan delete this subject
    // but clik done update this subject by delete then add by new info
  }

  static void callSubjectThisTime(Time time) {}

  static void callInfoTable() {}

  static void callInfoSubject(Subject subject) {}
}
