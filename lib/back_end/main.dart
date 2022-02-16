import 'dart:convert';
import 'dart:io';
import 'TimeSub.dart';

import 'Timetable.dart';
import 'subject.dart';

void main(List<String> args) {
  //print(TimeTable.timetable.length);
  //var user2 = Subject.fromJson(jsonDecode(TimeTable.timetable2[0]));
  //rint(user2.name);

  TimeTable.addSubject(Subject('math', 'www.youtube.com', 'online',
      [TimeSub.forSubject("FrIDaY", 9, 00, 10, 30)]));

  print(TimeTable.listSubject[0].allTimeLearn[0].dayOfWeek);

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
