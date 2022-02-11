import 'Timetable.dart';

class Subject {
  late String name;
  late String link;
  late String learnAt;
  late String date;
  late String timeStart;
  late String timeEnd;

  Subject.deleteSubject(this.name, this.link, this.learnAt, this.date,
      this.timeStart, this.timeEnd);

  Subject.addSubject(this.name, this.link, this.learnAt, this.date,
      this.timeStart, this.timeEnd);

  Subject.editSubject(this.name, this.link, this.learnAt, this.date,
      this.timeStart, this.timeEnd);

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

  set setname(String name) => this.name = name;
  String get getname => name;
  String get getlink => link;
  String get getlearnAt => learnAt;
  String get getdate => date;
  String get gettimeStart => timeStart;
  String get gettimeEnd => timeEnd;
}

void main(List<String> args) {
  var subjec1 = Subject.addSubject(
      'mathhhhhh', 'www.youtube.com', 'online', 'monday', "9.00", "10.30");
  var subjec2 = Subject.addSubject(
      'mathh', 'www.youtube.com', 'online', 'monday', "9.00", "10.30");
  var subjec3 = Subject.addSubject(
      'mathhh', 'www.youtube.com', 'online', 'monday', "9.00", "10.30");
  var subjec4 = Subject.addSubject(
      'mathhhh', 'www.youtube.com', 'online', 'monday', "9.00", "10.30");
  var subjec5 = Subject.addSubject(
      'math', 'www.youtube.com', 'online', 'monday', "9.00", "10.30");
  var subjec6 = Subject.addSubject(
      'mathhhhhh', 'www.youtube.com', 'online', 'monday', "13.00", "14.00");

  //var timetable1 = TimeTable.addSubject(subjec1);

  TimeTable.addSubject(subjec1);
  //addSubject(subjec6);
  //addSubject(subjec2);
  //addSubject(subjec3);
  //addSubject(subjec4);

  //editSubject(subjec1);

  //allSubject.add(jsonEncode(subjec1.toJson()));
  //timetable.add(jsonEncode(subjec2.toJson()));
  //timetable.add(jsonEncode(subjec3.toJson()));
  //timetable.add(jsonEncode(subjec4.toJson()));
  //timetable.add(jsonEncode(subjec5.toJson()));

  /*var deleteSubject1 = Subject.deleteSubject(
      'math', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);*/
  var deleteSubject2 = Subject.deleteSubject(
      'mathhhhhh', 'www.youtube.com', 'online', 'monday', "13.00", "14.00");
  //subjectDelete = jsonEncode(deleteSubject1.toJson());

  //deleteSubject(deleteSubject1);
  //deleteSubject(deleteSubject2);

  //Timetable.editSubject(subjec1);
  TimeTable.editSubject(subjec1);

  /*for (int i = 0; i < allSubject.length; i++) {
    if (subjectDelete == allSubject[i]) { 
      print(i);
      allSubject.removeAt(i);
    }
  }*/

  print(TimeTable.listSubject[0].name);

  /*print(timetable[0]);
  var user = Subject.fromJson(jsonDecode(timetable[0]));
  print(user.name);
  print(user.link);
  print(user.learnAt);*/
}

class Time {
  late int dayOfWeek;
  late int hourStart;
  late int minuteStart;
  late int hourEnd;
  late int minuteEnd;

  late List<List<int>> timeSubject = [];

  late int date;
  late int month;
  late int year;

  Time.forSubject(this.dayOfWeek, this.hourStart, this.minuteStart,
      this.hourEnd, this.minuteEnd) {
    timeSubject.add([dayOfWeek, hourStart, minuteStart]);
    timeSubject.add([dayOfWeek, hourEnd, minuteEnd]);
  }

  Time.forTodo(this.date, this.month, this.year);

  int get getday => dayOfWeek;
  int get gethour => hourStart;
  int get getminute => dayOfWeek;
}
