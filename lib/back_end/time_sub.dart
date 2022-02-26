class TimeSub {
  late int dayOfWeek;
  late int hourStart;
  late int minuteStart;
  late int hourEnd;
  late int minuteEnd;

  @override
  bool operator ==(other) {
    return dayOfWeek == (other as TimeSub).dayOfWeek &&
        hourStart == other.hourStart &&
        minuteStart == other.minuteStart &&
        hourEnd == other.hourEnd &&
        minuteEnd == other.minuteEnd;
  }

  @override
  // TODO: implement hashCode
  int get hashCode {
    return minuteEnd +
        hourEnd * 60 +
        minuteStart * 60 * 24 +
        hourStart * 60 * 24 * 60 +
        dayOfWeek * 60 * 24 * 60 * 24;
  }

  static int strDayToInt(String dayOfWeek) {
    if (dayOfWeek.toLowerCase() == 'monday') {
      return 1;
    } else if (dayOfWeek.toLowerCase() == 'tuesday') {
      return 2;
    } else if (dayOfWeek.toLowerCase() == 'wednesday') {
      return 3;
    } else if (dayOfWeek.toLowerCase() == 'thursday') {
      return 4;
    } else if (dayOfWeek.toLowerCase() == 'friday') {
      return 5;
    } else if (dayOfWeek.toLowerCase() == 'saturday') {
      return 6;
    } else if (dayOfWeek.toLowerCase() == 'sunday') {
      return 7;
    }
    return -1;
  }

  static String intDayToStr(int indWeek) {
    List<String> dayOfWeek = [
      "????",
      "monday",
      "tuesday",
      "wednesday",
      "thursday",
      "friday",
      "saturday",
      "sunday"
    ];
    if (indWeek <= 0 || indWeek > 7) return "????";
    return dayOfWeek[indWeek];
  }

  TimeSub(String dayOfWeek, this.hourStart, this.minuteStart, this.hourEnd,
      this.minuteEnd) {
    this.dayOfWeek = TimeSub.strDayToInt(dayOfWeek);
  }

  TimeSub.fromSubjectToTime(TimeSub pre) {
    dayOfWeek = pre.dayOfWeek;
    hourStart = pre.hourStart;
    minuteStart = pre.minuteStart;
  }

  int get getday => dayOfWeek;
  int get gethour => hourStart;
  int get getminute => dayOfWeek;

  TimeSub.fromJson(Map<String, dynamic> json) {
    dayOfWeek = json['dayOfWeek'];
    hourStart = json['hourStart'];
    minuteStart = json['minuteStart'];
    hourEnd = json['hourEnd'];
    minuteEnd = json['minuteEnd'];
  }

  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'hourStart': hourStart,
      'minuteStart': minuteStart,
      'hourEnd': hourEnd,
      'minuteEnd': minuteEnd,
    };
  }

  static int toHashing(TimeSub tim) {
    int result = 0;
    result += tim.dayOfWeek * 10000;
    result += tim.hourStart * 100;
    result += tim.minuteStart;
    return result;
  }

  static bool isInBetween(TimeSub lr, TimeSub timToCal, bool isInclusive) {
    if (lr.dayOfWeek != timToCal.dayOfWeek) return false;

    if (isInclusive) {
      //? L1      R1      ( lr )
      //?    [t]          ( timToCal )
      if ((timToCal.hourStart > lr.hourStart ||
              (timToCal.hourStart == lr.hourStart &&
                  timToCal.minuteStart >= lr.minuteStart)) &&
          (timToCal.hourStart < lr.hourEnd ||
              (timToCal.hourStart == lr.hourEnd &&
                  timToCal.minuteStart <= lr.minuteEnd))) {
        return true;
      }
    } else {
      //? L1+1      R1-1      ( lr )
      //?      [t]          ( timToCal )
      if ((timToCal.hourStart > lr.hourStart ||
              (timToCal.hourStart == lr.hourStart &&
                  timToCal.minuteStart >= lr.minuteStart + 1)) &&
          (timToCal.hourStart < lr.hourEnd ||
              (timToCal.hourStart == lr.hourEnd &&
                  timToCal.minuteStart <= lr.minuteEnd - 1))) {
        return true;
      }
    }
    return false;
  }

  static bool isOverlapTime(TimeSub a, TimeSub b) {
    if (a.dayOfWeek == b.dayOfWeek) {
      //? Case 1
      //? L1(+1)      R1(-1)        ( b )
      //?        [L2]  ... R2   ( a )
      if (isInBetween(b, TimeSub.fromSubjectToTime(a), false)) {
        return true;
      }

      //? Case 2
      //?          L1(+1)      R1(-1)   ( b )
      //?    L2  ...      [R2]      ( a )
      if (isInBetween(b, TimeSub.fromSubjectToTime(a), false)) {
        return true;
      }
    }
    return false;
  }

  int compareToStartTime(TimeSub other) {
    if (this.dayOfWeek < other.dayOfWeek) {
      return -1;
    }
    if (this.dayOfWeek > other.dayOfWeek) {
      return 1;
    }

    if (this.hourStart < other.hourStart) {
      return -1;
    }
    if (this.hourStart > other.hourStart) {
      return 1;
    }

    if (this.minuteStart < other.minuteStart) {
      return -1;
    }
    if (this.minuteStart > other.minuteStart) {
      return 1;
    }

    return 0;
  }

  @override
  String toString() {
    return "${TimeSub.intDayToStr(dayOfWeek)} ${hourStart}:${minuteStart} to ${hourEnd}:${minuteEnd}";
  }
}
