class Todo {
  late String name;
  late String link;
  late String learnAt;
  //late int date;
  //late int timeStart;
  //late List timeEnd;
  late List allTimeLearn;

  /*Subject.deleteSubject(this.name, this.link, this.learnAt, this.date,
      this.timeStart, this.timeEnd);*/

  /*Subject.addSubject(this.name, this.link, this.learnAt, this.date,
      this.timeStart, this.timeEnd);*/

  /*Subject.editSubject(this.name, this.link, this.learnAt, this.date,
      this.timeStart, this.timeEnd);*/

  Todo.addSubject(this.name, this.link, this.learnAt, this.allTimeLearn);
  Todo.deleteSubject(this.name, this.link, this.learnAt, this.allTimeLearn);
  //Subject.editSubjectt(this.name, this.link, this.learnAt, this.allTimeLearn);

  Todo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    link = json['link'];
    learnAt = json['learnAt'];
    /*date = json['date'];
    timeStart = json['timeStart'];
    timeEnd = json['timeEnd'];*/
    allTimeLearn = json['allTimeLearn'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'link': link,
        'learnAt': learnAt,
        /*'date': date,
        'timeStart': timeStart,
        'timeEnd': timeEnd,*/
        'allTimeLearn': allTimeLearn
      };
  String get getname => name;
  String get getlink => link;
  String get getlearnAt => learnAt;
  /*String get getdate => date;
  String get gettimeStart => timeStart;
  String get gettimeEnd => timeEnd;*/
}