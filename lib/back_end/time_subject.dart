class TimeSubject {
  String date = 'late';
  double timeStart = 0;
  double timeEnd = 0;

  TimeSubject(this.date, this.timeStart, this.timeEnd);

  List<TimeSubject> timeSubject = [];

  TimeSubject.fromJson(List<TimeSubject> json) {
    /*date = json['date'];
    timeStart = json['timeStart'];
    timeEnd = json['timeEnd'];*/
  }
}

void main(List<String> args) {}
