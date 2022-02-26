import 'dart:math';

import 'time_todo.dart';

class Todo {
  late String name;
  late String info;
  late TimeTodo atTime;
  late int id;

  /*Subject.deleteSubject(this.name, this.link, this.learnAt, this.date,
      this.timeStart, this.timeEnd);*/

  /*Subject.addSubject(this.name, this.link, this.learnAt, this.date,
      this.timeStart, this.timeEnd);*/

  /*Subject.editSubject(this.name, this.link, this.learnAt, this.date,
      this.timeStart, this.timeEnd);*/

  void genRandomId() {
    final thatRandom = Random();
    id = thatRandom.nextInt(1 << 32);
  }

  Todo(this.name, this.info, this.atTime) {
    genRandomId();
  }
  Todo.raw(this.name, this.info, int minute, int hour, int date, int month,
      int year) {
    atTime.dayOfMonth = date;
    atTime.monthOfYear = month;
    atTime.year = year;
    genRandomId();
  }

  Todo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    info = json['info'];
    id = json['id'];

    atTime = TimeTodo.fromJson(json['atTime']);
  }

  Map<String, dynamic> toJson() =>
      {'name': name, 'info': info, 'atTime': atTime, 'id': id};
}
