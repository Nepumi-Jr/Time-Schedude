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
  String get getname => name;
  String get getlink => link;
  String get getlearnAt => learnAt;
  String get getdate => date;
  String get gettimeStart => timeStart;
  String get gettimeEnd => timeEnd;
}
