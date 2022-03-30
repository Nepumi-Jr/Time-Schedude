import 'package:sendlink_application/back_end/time_sub.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Subject {
  late String name;
  late String link;
  late String learnAt;

  late int id;
  late List<int> allTimeId;
  late List<TimeSub> allTimeLearn;

  Subject(this.name, this.link, this.learnAt, this.allTimeLearn);

  void doGenTimeId() {
    allTimeId = [];
    for (var e in allTimeLearn) {
      allTimeId.add(getHashTime(e));
    }
  }

  int getHashTime(TimeSub tim) {
    int result = id * 100000;
    result += TimeSub.toHashing(tim);
    return result;
  }

  int getIndOfTime(TimeSub tim) {
    for (int i = 0; i < allTimeLearn.length; i++) {
      if (allTimeLearn[i].dayOfWeek == tim.dayOfWeek &&
          allTimeLearn[i].hourStart == tim.hourStart &&
          allTimeLearn[i].minuteStart == tim.minuteStart) {
        return i;
      }
    }
    return -1;
  }

  Subject.fromJson(Map<String, dynamic> json) {
    allTimeLearn = [];
    for (var tim in json['allTimeLearn']) {
      allTimeLearn.add(TimeSub.fromJson(tim));
    }
    allTimeId = [];
    for (var timId in json['allTimeId']) {
      allTimeId.add(timId);
    }
    name = json['name'];
    link = json['link'];
    learnAt = json['learnAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'link': link,
        'learnAt': learnAt,
        /*'date': date,
        'timeStart': timeStart,
        'timeEnd': timeEnd,*/
        'allTimeLearn': allTimeLearn,
        'id': id,
        'allTimeId': allTimeId
      };
}
