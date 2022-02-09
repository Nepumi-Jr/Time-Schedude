import 'dart:convert';
import 'dart:io';
//import 'package:path_provider/path_provider.dart';

class Subject {
  late String name;
  late String link;
  late String learnAt;
  late String date;
  late double timeStart;
  late double timeEnd;

  Subject.deleteSubject(this.name, this.link, this.learnAt, this.date,
      this.timeStart, this.timeEnd);

  Subject.addSubject(this.name, this.link, this.learnAt, this.date,
      this.timeStart, this.timeEnd);

  Subject.editSubject(this.name, this.link, this.learnAt, this.date,
      this.timeStart, this.timeEnd);

  Subject.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    link = json['link'];
    learnAt = json['learnAt'];
    date = json['date'];
    timeStart = json['timeStart'];
    timeEnd = json['timeEnd'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'link': link,
        'learnAt': learnAt,
        'date': date,
        'timeStart': timeStart,
        'timeEnd': timeEnd
      };

  String get getname => name;
  set setname(String name) => this.name = name;
}

List<String> timetable = [];
List<List<double>> timeSubject = [];
late String subjectDelete;
late String nameEditSubject;
late String nameSubjectDelete;
late int numSubject;

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

void addSubject(Subject subject) {
  timetable.add(jsonEncode(subject.toJson()));
  timeSubject.add([subject.timeStart, subject.timeEnd]);
}

void deleteSubject(Subject subject) {
  nameSubjectDelete = subject.getname;
  List<double> timeLearn = [];
  timeLearn.add(subject.timeStart);
  timeLearn.add(subject.timeEnd);

  for (int i = 0; i < timetable.length; i++) {
    var nameSubject = Subject.fromJson(jsonDecode(timetable[i]));
    if (nameSubjectDelete == nameSubject.name) {
      if (timeLearn.join(",") == timeSubject[i].join(",")) {
        numSubject = i;
      }
    }
  }

  timetable.removeAt(numSubject);

  /* subjectDelete = jsonEncode(subject.toJson());
  for (int i = 0; i < timetable.length; i++) {
    if (subjectDelete == timetable[i]) {
      timetable.removeAt(i);
    }
  }*/
}

void editSubject(Subject subject) {
  // ลบ แล้วเพิ่มใหม่?
  subjectDelete = jsonEncode(subject.toJson());
  subject.name = 'ggggg';

  /*nameEditSubject = subject.getname;
  List<double> timeLearn = [];
  timeLearn.add(subject.timeStart);
  timeLearn.add(subject.timeEnd);

  for (int i = 0; i < timetable.length; i++) {
    var nameSubject = Subject.fromJson(jsonDecode(timetable[i]));
    if (nameEditSubject == nameSubject.name) {
      if (timeLearn.join(",") == timeSubject[i].join(",")) {
        numSubject = i;
      }
    }
  }*/
}

void main(List<String> args) {
  var subjec1 = Subject.addSubject(
      'mathhhhhh', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);
  var subjec2 = Subject.addSubject(
      'mathh', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);
  var subjec3 = Subject.addSubject(
      'mathhh', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);
  var subjec4 = Subject.addSubject(
      'mathhhh', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);
  var subjec5 = Subject.addSubject(
      'math', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);
  var subjec6 = Subject.addSubject(
      'mathhhhhh', 'www.youtube.com', 'online', 'monday', 13.00, 14.00);

  addSubject(subjec1);
  addSubject(subjec6);
  //addSubject(subjec2);
  //addSubject(subjec3);
  //addSubject(subjec4);

  //editSubject(subjec1);

  //allSubject.add(jsonEncode(subjec1.toJson()));
  //timetable.add(jsonEncode(subjec2.toJson()));
  //timetable.add(jsonEncode(subjec3.toJson()));
  //timetable.add(jsonEncode(subjec4.toJson()));
  //timetable.add(jsonEncode(subjec5.toJson()));

  /*var deleteSubject1 = Subject.deleteSubject(
      'math', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);*/
  var deleteSubject2 = Subject.deleteSubject(
      'mathhhhhh', 'www.youtube.com', 'online', 'monday', 13.00, 14.00);
  //subjectDelete = jsonEncode(deleteSubject1.toJson());

  //deleteSubject(deleteSubject1);
  deleteSubject(deleteSubject2);

  editSubject(subjec1);

  /*for (int i = 0; i < allSubject.length; i++) {
    if (subjectDelete == allSubject[i]) {
      print(i);
      allSubject.removeAt(i);
    }
  }*/

  print(timetable);

  /*print(timetable[0]);
  var user = Subject.fromJson(jsonDecode(timetable[0]));
  print(user.name);
  print(user.link);
  print(user.learnAt);*/
}
