import 'package:sendlink_application/back_end/TimeSub.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Subject {
  late String name;
  late String link;
  late String learnAt;

  late int id;
  late List<int> allTimeId;
  late List<TimeSub> allTimeLearn;

  /*Subject.deleteSubject(this.name, this.link, this.learnAt, this.date,
      this.timeStart, this.timeEnd);*/

  /*Subject.addSubject(this.name, this.link, this.learnAt, this.date,
      this.timeStart, this.timeEnd);*/

  /*Subject.editSubject(this.name, this.link, this.learnAt, this.date,
      this.timeStart, this.timeEnd);*/

  Subject(this.name, this.link, this.learnAt, this.allTimeLearn);
  Subject.deleteSubject(this.name, this.link, this.learnAt, this.allTimeLearn);
  //Subject.editSubjectt(this.name, this.link, this.learnAt, this.allTimeLearn);

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

  Subject.fromJson(Map<String, dynamic> json) {
    allTimeLearn = [];
    for (var tim in json['allTimeLearn']) {
      allTimeLearn.add(TimeSub.fromJson(tim));
    }
    allTimeId = [];
    for (var timId in json['allTimeId']) {
      allTimeLearn.add(timId);
    }
    name = json['name'];
    link = json['link'];
    learnAt = json['learnAt'];
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
