import 'dart:convert';

class Subject {
  late String name;
  late String link;
  late String learnAt;
  late String date;
  late double timeStart;
  late double timeEnd;

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
}

List<String> allSubject = [];
late String subjectDelete;

void addSubject(Subject subject) {
  allSubject.add(jsonEncode(subject.toJson()));
}

void deleteSubject(Subject subject) {
  subjectDelete = jsonEncode(subject.toJson());
  for (int i = 0; i < allSubject.length; i++) {
    if (subjectDelete == allSubject[i]) {
      print(i);
      allSubject.removeAt(i);
    }
  }
}

void main(List<String> args) {
  var subjec1 = Subject.addSubject(
      'mathhhhhh', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);
  var subjec2 = Subject.addSubject(
      'mathh', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);
  var subjec3 = Subject.addSubject(
      'mathhh', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);
  var subjec4 = Subject.addSubject(
      'mathhhh', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);
  var subjec5 = Subject.addSubject(
      'math', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);

  addSubject(subjec1);

  //allSubject.add(jsonEncode(subjec1.toJson()));
  allSubject.add(jsonEncode(subjec2.toJson()));
  allSubject.add(jsonEncode(subjec3.toJson()));
  allSubject.add(jsonEncode(subjec4.toJson()));
  allSubject.add(jsonEncode(subjec5.toJson()));

  var deleteSubject1 = Subject.deleteSubject(
      'math', 'www.youtube.com', 'online', 'monday', 9.00, 10.30);
  //subjectDelete = jsonEncode(deleteSubject1.toJson());

  deleteSubject(deleteSubject1);

  /*for (int i = 0; i < allSubject.length; i++) {
    if (subjectDelete == allSubject[i]) {
      print(i);
      allSubject.removeAt(i);
    }
  }*/

  print(allSubject);

  print(allSubject[0]);
  var user = Subject.fromJson(jsonDecode(allSubject[0]));
  print(user.name);
  print(user.link);
  print(user.learnAt);
}
