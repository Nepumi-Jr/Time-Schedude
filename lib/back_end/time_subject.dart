class Time {
  String day = "";
  String time_start = "";
  String time_end = "";
  List<String> time_learn = [];

  Time(this.day, this.time_start, this.time_end) {
    var tmpArray = {'day': day, 'time_start': time_start, 'time_end': time_end};
  }

  String get get_day => day;
  String get get_time_start => time_start;
  String get get_time_end => time_end;

  set set_day(String day) => day;
  set set_time_start(String time_start) => time_start;
  set set_time_end(String time_end) => time_end;

  @override
  toString() {
    // TODO: implement toString
    return "day : " +
        day +
        "\ntime start : " +
        time_start +
        "\ntime end : " +
        time_end;
  }
}

void main(List<String> args) {
  Time time1 = Time('monday', '18.00', '20.00');
}
