import 'Timetable.dart';
import 'subject.dart';

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
