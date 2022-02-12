import 'dart:convert';
import 'dart:io';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:path_provider/path_provider.dart';

class Subject {
  late String name;
  late String link;
  late String learnAt;
  late String date;
  late double timeStart;
  late double timeEnd;

  Map<String, dynamic> minorListSubject = {};

  Subject.forsubject(this.name, this.link, this.learnAt, this.date,
      this.timeStart, this.timeEnd) {
    minorListSubject.addAll(toJson());
    //print(minorListSubject);
    //TimeTable();
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

/* class TimeTable {
  List<Map> listSubject = [];
  Map<String, dynamic> dicSubject = {};

  TimeTable() {
    //print(Subject().getSubject);
    listSubject.add(Subject().getSubject);
    //print(listSubject);
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
} */

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

  List<Map> allSubject = [];
  allSubject.add(subjec1.toJson());
  allSubject.add(subjec2.toJson());
  allSubject.add(subjec3.toJson());
  allSubject.add(subjec4.toJson());
  allSubject.add(subjec5.toJson());
  print(allSubject);
  var neww = jsonEncode(allSubject[0]);

  var user = Subject.fromJson(jsonDecode(neww));
  print(user.name);
  print(user.link);
}
