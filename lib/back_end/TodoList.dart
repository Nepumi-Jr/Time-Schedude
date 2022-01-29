/* date วันที่แก้ไขล่าสุด ตารางจด เวลา*/
import 'dart:convert';
import 'dart:io';

class Subject {
  String name = 'late';
  String last_edit = 'late';
  String date = 'late';
  double timeStart = 0;
  double timeEnd = 0;

  List<double> timeSubject = [];
  //Map<String, String> infoSubject = {};

  Subject(this.name, this.last_edit, this.date, this.timeStart, this.timeEnd);

  Subject.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    last_edit = json['learnAt'];
    date = json['date'];
    timeStart = json['timeStart'];
    timeEnd = json['timeEnd'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'learnAt': last_edit,
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
  var subject1 = Subject('math', 'www.youtube.com', 'online', 9.00, 10.30);

  var jsonText = jsonEncode(subject1);
  print(jsonText.runtimeType); // String
  print(jsonText);
  var user = Subject.fromJson(jsonDecode(jsonText));
  print(user.name);

  File subject = File('D:\\New folder\\subject2.json');
  subject.writeAsStringSync(jsonText);
  print(subject.readAsStringSync());
  subject.deleteSync();
}
