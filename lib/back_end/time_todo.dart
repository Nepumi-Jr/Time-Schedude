import 'time_sub.dart';

class TimeTodo {
  late int timeMinute;
  late int timeHour;
  late int dayOfMonth;
  late int monthOfYear;
  late int year;

  TimeTodo(this.timeHour, this.timeMinute, this.dayOfMonth, this.monthOfYear,
      this.year);

  TimeTodo.fromJson(Map<String, dynamic> json) {
    timeMinute = json['timeMinute'];
    timeHour = json['timeHour'];
    dayOfMonth = json['dayOfMonth'];
    monthOfYear = json['monthOfYear'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    return {
      'timeMinute': timeMinute,
      'timeHour': timeHour,
      'dayOfMonth': dayOfMonth,
      'monthOfYear': monthOfYear,
      'year': year,
    };
  }
}
