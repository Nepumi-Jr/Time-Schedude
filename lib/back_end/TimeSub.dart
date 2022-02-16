class TimeSub {
  late int dayOfWeek;
  late int hourStart;
  late int minuteStart;
  late int hourEnd;
  late int minuteEnd;

  int date = 0;
  int month = 0;
  int year = 0;

  TimeSub.forSubject(String dayOfWeek, this.hourStart, this.minuteStart,
      this.hourEnd, this.minuteEnd) {
    chengeStringDayToInt(dayOfWeek);
  }

  TimeSub.forTodo(this.date, this.month, this.year);

  int get getday => dayOfWeek;
  int get gethour => hourStart;
  int get getminute => dayOfWeek;
  void chengeStringDayToInt(String dayOfWeek) {
    if (dayOfWeek.toLowerCase() == 'monday') {
      this.dayOfWeek = 1;
    } else if (dayOfWeek.toLowerCase() == 'tuesday') {
      this.dayOfWeek = 2;
    } else if (dayOfWeek.toLowerCase() == 'wednesday') {
      this.dayOfWeek = 3;
    } else if (dayOfWeek.toLowerCase() == 'thursday') {
      this.dayOfWeek = 4;
    } else if (dayOfWeek.toLowerCase() == 'friday') {
      this.dayOfWeek = 5;
    } else if (dayOfWeek.toLowerCase() == 'saturday') {
      this.dayOfWeek = 6;
    } else if (dayOfWeek.toLowerCase() == 'subday') {
      this.dayOfWeek = 7;
    }
  }

  TimeSub.fromJson(Map<String, dynamic> json) {
    dayOfWeek = json['dayOfWeek'];
    hourStart = json['hourStart'];
    minuteStart = json['minuteStart'];
    hourEnd = json['hourEnd'];
    minuteEnd = json['minuteEnd'];

    date = json['date'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'hourStart': hourStart,
      'minuteStart': minuteStart,
      'hourEnd': hourEnd,
      'minuteEnd': minuteEnd,
      'date': date,
      'month': month,
      'year': year,
    };
  }
}
