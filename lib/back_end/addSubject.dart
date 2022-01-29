import 'dart:convert';
import 'dart:io';

import 'package:sendlink_application/back_end/storage.dart';

class Subject {
  String name = 'late';
  String link = 'late';
  String learnAt = 'late';
  String date = 'late';
  double timeStart = 0;
  double timeEnd = 0;

  List<double> timeSubject = [];
  //Map<String, String> infoSubject = {};

  Subject(this.name, this.link, this.learnAt, this.date, this.timeStart,
      this.timeEnd);

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

  /*void addTimeSubject() {
    timeSubject.add(time);
    timeSubject.add(time2);
  }

  void addInfoSubject() {
    infoSubject['name'] = name;
    infoSubject['link'] = link;
    infoSubject['learnAt'] = learnAt;
    infoSubject['day'] = day;
  }*/
}

void main(List<String> args) {
  var subject1 =
      Subject('math', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);

  var jsonText = jsonEncode(subject1);
  print(jsonText.runtimeType); // String
  print(jsonText);
  var user = Subject.fromJson(jsonDecode(jsonText));
  print(user.name);
  print(user.link);

  File subject = File('D:\\New folder\\subject2.json');
  subject.writeAsStringSync(jsonText);
  print(subject.readAsStringSync());
  subject.deleteSync();
}
