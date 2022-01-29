import 'dart:convert';

class Subject {
  late String name;
  late String time_start;
  late String time_end;
  late String date;
  late String link;
  late String place;

  Subject(
      {required this.name,
      required this.time_start,
      required this.time_end,
      required this.date,
      required this.link,
      required this.place});

  Subject.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    time_start = json['time_start'];
    time_end = json['time_end'];
    date = json['date'];
    link = json['link'];
    place = json['place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['time_start'] = this.time_start;
    data['time_end'] = this.time_end;
    data['date'] = this.date;
    data['link'] = this.link;
    data['place'] = this.place;
    return data;
  }
}

void main(List<String> args) {
  var userJson =
      '{"name":"Calculas IV","time_start": "09:00","time_end":"13:00","date":"sunday","link":"www.gooogle.com","place":"online"}';

  var subject = Subject.fromJson(jsonDecode(userJson));
  print(subject.name);
  print(subject.time_start);
  print(subject.time_end);
  print(subject.date);
  print(subject.link);
  print(subject.place);

  var userJsonEncoded = jsonEncode(subject.toJson());
  print(userJsonEncoded);
}
