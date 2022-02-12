import 'subject.dart';
import 'dart:convert';
import 'time.dart';
//import 'dart:io';
//import 'package:path_provider/path_provider.dart';

class TimeTable {
  static List<Subject> listSubject = [];
  static List<String> timetable = [];
  static List<List<String>> timeSubject = [];
  static late String nameEditSubject;
  static late String nameSubjectDelete;
  static late int numSubjectDelete;
  static late int numListSubjectDelete;

  /*Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  } 

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/subject.json');
  }

  Future<File> writeSubject(String subject) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(subject);
  }

  Future<String> readSubject() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error
      return 'encountering an error';
    }
  }*/

  void saveSubject() {}

  void loadSubject() {}

  void insertSubject() {}

  static void splitTime(Subject subject) {
    var listTimeStart = subject.timeStart.split('.');
    var listTimeEnd = subject.timeEnd.split('.');

    var hourStart = int.parse(listTimeStart[0]);
    var minuteStart = int.parse(listTimeStart[1]);
    var hourEnd = int.parse(listTimeEnd[0]);
    var minuteEnd = int.parse(listTimeEnd[1]);

    Time.forSubject(subject.date, hourStart, minuteStart, hourEnd, minuteEnd);
  }

  static void addSubject(Subject subject) {
    listSubject.add(subject);

    timetable.add(jsonEncode(subject.toJson()));
    timeSubject.add([subject.timeStart, subject.timeEnd]);

    splitTime(subject);
  }

  static void deleteSubject(Subject subject) {
    nameSubjectDelete = subject.getname;
    List<String> timeLearn = [];
    timeLearn.add(subject.timeStart);
    timeLearn.add(subject.timeEnd);

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
