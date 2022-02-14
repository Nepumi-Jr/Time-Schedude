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
  static int numSubjectDelete = 1000;
  static int numListSubjectDelete = 1000;
  static late List<String> result;

  static void saveSubject() {
    var file = File('dataSubject.json');
    var sink = file.openWrite();
    sink.write(timetable);

    // Close the IOSink to free system resources.
    sink.close();
  }

  static void loadSubject() {
    File('dataSubject.json').readAsString().then((String contents) {
      String test = contents.substring(1, contents.length - 1);

      result = test.split(', ');
      print(result[0]);

      //timetable2.add(result[0]);
      //timetable2.add(result[1]);

      //print(timetable2);

      //var user2 = Subject.fromJson(jsonDecode(TimeTable.timetable2[0]));
      //print(user2.name);
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

    //writeCounter(timetable[0]);

    //saveSubject();
  }

  static void deleteSubject(Subject subject) {
    for (int i = 0; i < timetable.length; i++) {
      var nameSubject = Subject.fromJson(jsonDecode(timetable[i]));
      if (subject.name == nameSubject.name) {
        if (subject.link == nameSubject.link) {
          if (subject.learnAt == nameSubject.learnAt) {
            if (subject.allTimeLearn.join(",") ==
                nameSubject.allTimeLearn.join(",")) {
              numListSubjectDelete = i;
            }
          }
        }
      }
    }

    if (numListSubjectDelete != 1000) {
      timetable.removeAt(numListSubjectDelete);
    }

    for (int i = 0; i < timetable.length; i++) {
      var nameSubject = Subject.fromJson(jsonDecode(timetable[i]));
      if (subject.name == nameSubject.name) {
        if (subject.link == nameSubject.link) {
          if (subject.learnAt == nameSubject.learnAt) {
            if (subject.allTimeLearn.join(",") ==
                nameSubject.allTimeLearn.join(",")) {
              numSubjectDelete = i;
            }
          }
        }
      }
    }

    if (numSubjectDelete != 1000) {
      timetable.removeAt(numSubjectDelete);
    }

    print(timetable);

    //saveSubject();
  }

  static void editSubject(Subject subject) {
    // click edit then check if click trashcan delete this subject
    // but clik done update this subject by delete then add by new info
  }

  static void callSubjectThisTime(Time time) {}

  static void callInfoTable() {}

  static void callInfoSubject(Subject subject) {}

  /*static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  static Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 'encountering an error';
    }
  }

  static Future<File> writeCounter(String counter) async {
    final file = await _localFile;

    print(counter);

    // Write the file
    return file.writeAsString(counter);
  }*/
}
