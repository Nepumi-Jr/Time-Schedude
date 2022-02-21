import 'dart:convert';
import 'dart:io';
import 'TimeSub.dart';

import 'Timetable.dart';
import 'subject.dart';

import 'dart:convert';
import 'package:crypto/crypto.dart';

void main(List<String> args) {
  //print(TimeTable.timetable.length);
  //var user2 = Subject.fromJson(jsonDecode(TimeTable.timetable2[0]));
  //rint(user2.name);

  TimeTable.addSubject(Subject('math', 'www.youtube.com', 'online', [
    TimeSub.forSubject("FrIDaY", 9, 00, 10, 30),
    TimeSub.forSubject("MOnDAy", 17, 32, 18, 11)
  ]));
  print(TimeTable.tToString());

  TimeTable.addTimeToSubject(
      "math", TimeSub.forSubject("Wednesday", 9, 30, 12, 00));

  print(TimeTable.tToString());

  TimeTable.addSubject(Subject('life', 'www.pornhub.com', 'online',
      [TimeSub.forSubject("Tuesday", 9, 00, 10, 30)]));
  print(TimeTable.tToString());

  print("-----------------------------------------");

  TimeTable.editSubject("math", Subject("cal kuay", "googoo", "hell", []));
  print(TimeTable.tToString());

  TimeTable.editSubject(
      "cal kuay", Subject("cal kuay", "pondhub", "heaven", []));
  print(TimeTable.tToString());

  print("Test time DUL");

  print(TimeSub.isOverlapTime(TimeSub.forSubject("monday", 10, 29, 12, 00),
      TimeSub.forSubject("monday", 9, 00, 10, 30)));

  //print(TimeTable.listSubject[0].allTimeLearn);
  //TimeTable.loadSubject();
  // TimeTable.addSubject(Subject.addSubject('math', 'www.youtube.com', 'online', [
  //   [4, 8, 0, 20, 0],
  //   [2, 14, 30, 17, 30]
  // ]));
  // TimeTable.addSubject(
  //     Subject.addSubject('englist', 'www.english.com', 'onsite', [
  //   [3, 7, 30, 19, 30],
  //   [1, 13, 0, 16, 00]
  // ]));

  //print(TimeTable.timetable.length);

  /*TimeTable.deleteSubject(
      Subject.deleteSubject('englist', 'www.english.com', 'onsite', [
    [3, 7, 30, 19, 30],
    [1, 13, 0, 16, 00]
  ]));*/

  //print(TimeTable.timetable[0]);

  // print(tername);

  //print(TimeTable.listSubject[0].allTimeLearn[0][2]);

  //print(TimeTable.timetable2);

  //print(TimeTable.listSubject[0].allTimeLearn);

  //var user = Subject.fromJsonButListTime(jsonDecode(TimeTable.timetable[0]));

  /*var user = Subject.fromJson(jsonDecode(TimeTable.timetable[0]));
  print(user.name);
  print(user.link);
  print(user.learnAt);
  //print(user.date);
  //print(user.timeEnd[0][2]);
  print(user.allTimeLearn);*/
}
