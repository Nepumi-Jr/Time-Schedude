class Time {
  late int dayOfWeek;
  late int hourStart;
  late int minuteStart;
  late int hourEnd;
  late int minuteEnd;

  static List<List<int>> timeSubject = [];

  late int date;
  late int month;
  late int year;

  Time.forSubject(String dayOfWeek, this.hourStart, this.minuteStart,
      this.hourEnd, this.minuteEnd) {
    chengeStringDayToInt(dayOfWeek);
    timeSubject.add([this.dayOfWeek, hourStart, minuteStart]);
    timeSubject.add([this.dayOfWeek, hourEnd, minuteEnd]);
  }

  Time.forTodo(this.date, this.month, this.year);

  int get getday => dayOfWeek;
  int get gethour => hourStart;
  int get getminute => dayOfWeek;

  void chengeStringDayToInt(String dayOfWeek) {
    if (dayOfWeek == 'monday') {
      this.dayOfWeek = 1;
    } else if (dayOfWeek == 'tuesday') {
      this.dayOfWeek = 2;
    } else if (dayOfWeek == 'wednesday') {
      this.dayOfWeek = 3;
    } else if (dayOfWeek == 'thursday') {
      this.dayOfWeek = 4;
    } else if (dayOfWeek == 'friday') {
      this.dayOfWeek = 5;
    } else if (dayOfWeek == 'saturday') {
      this.dayOfWeek = 6;
    } else if (dayOfWeek == 'subday') {
      this.dayOfWeek = 7;
    }
  }
}
