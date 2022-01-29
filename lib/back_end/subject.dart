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

  Map<String, dynamic> minorListSubject = {};

  Subject() {
    getSubject;
  }

  Subject.forsubject(this.name, this.link, this.learnAt, this.date,
      this.timeStart, this.timeEnd) {
    minorListSubject.addAll(toJson());
    print(minorListSubject);
    TimeTable();
    //TimeTable().listSubject.add(toJson());
    //print(TimeTable().listSubject);
  }

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

  Map get getSubject {
    return {'minorListSubject': 'gdsgd'};
  }
}

class TimeTable {
  List<Map> listSubject = [];
  Map<String, dynamic> dicSubject = {};

  TimeTable() {
    print(Subject().getSubject);
    listSubject.add(Subject().getSubject);
    print(listSubject);
  }

  /*void addSubject() {
    listSubject.add(
        Subject('math', 'www.youtube.com', 'online', 'monday', 9.00, 10.30));
  }

  void deleteSubject(String name) {
    /*for(var i = 0; i < subject.length; i++) {
      if(subject[0])
    }*/
  }*/
}

/*class FileFunctions {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/subject.txt');
  }

  Future<String> readSubject() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 'ERROR';
    }
  }

  Future<File> writeCounter(String subject) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$subject');
  }
}*/

void main(List<String> args) {
  var subjec1 = Subject.forsubject(
      'math', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);
  var subjec2 = Subject.forsubject(
      'math', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);
  var subjec3 = Subject.forsubject(
      'math', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);
  var subjec4 = Subject.forsubject(
      'math', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);
  var subjec5 = Subject.forsubject(
      'math', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);

  /*var subject1 =
      Subject('math', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);

  var jsonText = jsonEncode(subject1);
  Subject('math', 'www.youtube.com', 'online', 'monday', 9.00, 10.30)
      .writeSubject(jsonText);

  print(jsonText.runtimeType); // String
  print(jsonText);
  var user = Subject.fromJson(jsonDecode(jsonText));
  print(user.name);
  print(user.link);

  File subject = File('subject2.json');
  subject.writeAsStringSync(jsonText);
  print(subject.readAsStringSync());
  //subject.deleteSync();
  print("Hello world");*/
}
