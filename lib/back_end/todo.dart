import 'dart:math';

import 'time_todo.dart';

class Todo {
  late String name;
  late String info;
  late TimeTodo atTime;
  late int id;
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  List<String> shortMonths = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  get description => null;

  zeroCheck(int time) {
    if (time == 0) {
      return "00";
    } else if (time < 10) {
      return "0" + time.toString();
    } else {
      return time.toString();
    }
  }

  void genRandomId() {
    final thatRandom = Random();
    id = thatRandom.nextInt(1 << 29);
  }

  String get timeTodo {
    TimeTodo time = atTime;
    var ter =
        "${shortMonths[time.moy - 1]} ${time.dom}, ${time.yrs} ${zeroCheck(time.timeHr)}:${zeroCheck(time.timeMn)}";
    return ter;
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
