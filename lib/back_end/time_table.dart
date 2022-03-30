import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sendlink_application/back_end/storage.dart';
import 'package:tuple/tuple.dart';

import 'time_todo.dart';
import 'subject.dart';
import 'todo.dart';
import 'dart:convert';
import 'time_sub.dart';
import 'link_check.dart';
import 'Reminder.dart';
import 'notification_api.dart';

import 'dart:io';
import 'package:icalendar_parser/icalendar_parser.dart';
//import 'storage.dart';

enum TimeTableStatus {
  done,
  duplicatedName,
  overlapTime,
  nameNotExist,
  timeNotExist
}

class TimeTable {
  static List<Subject> listSubject = [];
  static List<Todo> listTodo = [];
  static int idCounter = 0;

  //TimeTable

  static void saveFile() {
    String subjectJson = jsonEncode(listSubject);
    Storage.writeFile("subject.json", subjectJson);

    Storage.writeFile("id.dat", "$idCounter");

    String todoJson = jsonEncode(listTodo);
    Storage.writeFile("todo.json", todoJson);
  }

  static void loadFile() async {
    String subjectJson = await Storage.readFile("subject.json");
    loadSubjectsFromJson(subjectJson);

    idCounter = int.parse(await Storage.readFile("id.dat"));

    String todoJson = await Storage.readFile("todo.json");
    loadTodoFromJson(todoJson);

    //? Reload Notification
    pushNotiAll();
  }

  static void loadSubjectsFromJson(String sJSON) {
    List ll = jsonDecode(sJSON);
    listSubject = [];
    for (var e in ll) {
      listSubject.add(Subject.fromJson(e));
    }
  }

  static void loadTodoFromJson(String tJSON) {
    List ll = jsonDecode(tJSON);
    listTodo = [];
    for (var e in ll) {
      listTodo.add(Todo.fromJson(e));
    }
  }

  static void popNotiAll() {
    NotificationAPI.removeAll();
  }

  static void pushNotiAll() {
    pushNotiAllSub();
    pushNotiAllTodo();
  }

  static void pushNotiAllSub() {
    for (var e in listSubject) {
      pushNotiSub(e);
    }
  }

  static void pushNotiAllTodo() {
    for (var e in listTodo) {
      pushNotiTodo(e);
    }
  }

  static void pushNotiSub(Subject sub) {
    for (int i = 0; i < sub.allTimeLearn.length; i++) {
      pushNotiSubjectAtTime(sub, sub.allTimeLearn[i], sub.allTimeId[i]);
    }
  }

  static void pushNotiSubjectAtTime(Subject sub, TimeSub tim, int id) {
    Reminder remObj = Reminder();
    remObj.init();

    TimeSub realTime = TimeSub.addMinuteStart(tim, remObj.getReminder * -1);
    NotificationAPI.showWeeklyNotification(
        getID: id,
        getTitle: sub.name,
        getBody: sub.link,
        getDay: TimeSub.intDayToStrFirstCapital(tim.dayOfWeek),
        getTime: Time(realTime.hourStart, realTime.minuteStart, 0));
  }

  static void popNotiSub(Subject sub) {
    for (var e in sub.allTimeId) {
      popNotiSubjectAtTime(e);
    }
  }

  static void popNotiSubjectAtTime(int id) {
    NotificationAPI.removeId(id);
  }

  static TimeTableStatus addSubject(Subject subject) {
    //? Check name
    if (isExistName(subject.name)) {
      return TimeTableStatus.duplicatedName;
    }
    //? Check Times
    for (var e in subject.allTimeLearn) {
      if (isOverlapAnySubject(e)) {
        //! Overlap Time
        return TimeTableStatus.overlapTime;
      }
    }
    subject.id = idCounter;
    subject.doGenTimeId();
    listSubject.add(subject);
    saveFile();
    pushNotiSub(subject);
    idCounter++;
    return TimeTableStatus.done;
  }

  static int getSubjectIndexFromName(String subjectName) {
    for (int i = 0; i < listSubject.length; i++) {
      if (listSubject[i].name.toLowerCase() == subjectName.toLowerCase()) {
        return i;
      }
    }
    return -1;
  }

  static bool isExistName(String subjectName) {
    return getSubjectIndexFromName(subjectName) != -1;
  }

  static TimeTableStatus addTimeToSubject(String subjectName, TimeSub newTime) {
    int ind = getSubjectIndexFromName(subjectName);
    if (ind == -1) {
      //! หาวิชาไม่เจอ
      return TimeTableStatus.nameNotExist;
    }
    if (isOverlapAnySubject(newTime)) {
      //! Overlap Time
      return TimeTableStatus.overlapTime;
    }
    int timeId = listSubject[ind].getHashTime(newTime);
    listSubject[ind].allTimeLearn.add(newTime);
    listSubject[ind].allTimeId.add(timeId);
    pushNotiSubjectAtTime(listSubject[ind], newTime, timeId);
    saveFile();
    return TimeTableStatus.done;
  }

  static TimeTableStatus removeSubject(String subjectName) {
    int ind = getSubjectIndexFromName(subjectName);
    if (ind == -1) {
      //! หาวิชาไม่เจอ!!!
      return TimeTableStatus.nameNotExist;
    }
    popNotiSub(listSubject[ind]);
    listSubject.removeAt(ind);
    saveFile();
    return TimeTableStatus.done;
  }

  static TimeTableStatus removeSubjectTime(String subjectName, TimeSub tim) {
    int ind = getSubjectIndexFromName(subjectName);
    if (ind == -1) {
      //! หาวิชาไม่เจอ!!!
      return TimeTableStatus.nameNotExist;
    }
    int timInd = listSubject[ind].getIndOfTime(tim);
    if (timInd == -1) {
      //! อย่าหลอน
      return TimeTableStatus.timeNotExist;
    }
    popNotiSubjectAtTime(listSubject[ind].allTimeId[timInd]);
    listSubject[ind].allTimeLearn.removeAt(timInd);
    saveFile();
    return TimeTableStatus.done;
  }

  static void clearSubjects() {
    for (var e in listSubject) {
      popNotiSub(e);
    }
    listSubject = [];
    idCounter = 0;
    saveFile();
  }

  static TimeTableStatus editSubject(
      String subjectOldName, Subject theNewSubject) {
    int ind = getSubjectIndexFromName(subjectOldName);
    Subject oldSubj = listSubject[ind];
    listSubject.removeAt(ind);
    //? Check name
    if (isExistName(theNewSubject.name)) {
      //! Duplicated name
      listSubject.add(oldSubj);
      return TimeTableStatus.duplicatedName;
    }
    //? Check Times
    for (var e in theNewSubject.allTimeLearn) {
      if (isOverlapAnySubject(e)) {
        //! Overlap Time
        listSubject.add(oldSubj);
        return TimeTableStatus.overlapTime;
      }
    }
    popNotiSub(oldSubj);
    theNewSubject.id = oldSubj.id;
    theNewSubject.allTimeId = oldSubj.allTimeId;
    theNewSubject.allTimeLearn = oldSubj.allTimeLearn;
    pushNotiSub(theNewSubject);

    listSubject.add(theNewSubject);
    saveFile();
    return TimeTableStatus.done;
  }

  static TimeTableStatus editSubjectTime(
      String subjectName, TimeSub oldTime, TimeSub newTime) {
    int timId =
        listSubject[getSubjectIndexFromName(subjectName)].getIndOfTime(oldTime);
    removeSubjectTime(subjectName, oldTime);
    if (isOverlapAnySubject(newTime)) {
      //! Overlap Time
      addTimeToSubject(subjectName, oldTime);
      return TimeTableStatus.overlapTime;
    }
    popNotiSubjectAtTime(timId);
    addTimeToSubject(subjectName, newTime);
    saveFile();
    return TimeTableStatus.done;
  }

  static bool isOverlapAnySubject(TimeSub tim) {
    for (var e in listSubject) {
      for (var f in e.allTimeLearn) {
        if (TimeSub.isOverlapTime(f, tim)) {
          return true;
        }
      }
    }
    return false;
  }

  static Tuple2<String, TimeSub> getSubjectAtTime(
      String dayOfWeek, int hour, int minute) {
    for (var e in listSubject) {
      for (var f in e.allTimeLearn) {
        if (TimeSub.isInBetween(
            f, TimeSub(dayOfWeek, hour, minute, 0, 0), true)) {
          Reminder remObj = Reminder();
          remObj.init();
          if (remObj.isNoClass != 0) {
            return Tuple2("-", TimeSub("Monday", 0, 0, 0, 0));
          }
          return Tuple2(e.name, f);
        }
      }
    }
    return Tuple2("-", TimeSub("Monday", 0, 0, 0, 0));
  }

  static List<Tuple2<String, TimeSub>> getSubjectAtDay(String dayOfWeek) {
    List<Tuple2<String, TimeSub>> result = [];
    int iDayOfWeek = TimeSub.strDayToInt(dayOfWeek);
    for (var e in listSubject) {
      for (var f in e.allTimeLearn) {
        if (f.dayOfWeek == iDayOfWeek) {
          Reminder remObj = Reminder();
          remObj.init();
          if (remObj.isNoClass != 0) {
            return [];
          }
          result.add(Tuple2(e.name, f));
        }
      }
    }
    result.sort((a, b) {
      return a.item2.compareToStartTime(b.item2);
    });

    return result;
  }

  static List<Tuple2<String, TimeSub>> getSubjectsDoneAtTime(
      String dayOfWeek, int hour, int minute) {
    int iDayOfWeek = TimeSub.strDayToInt(dayOfWeek);
    List<Tuple2<String, TimeSub>> result = [];
    for (var e in listSubject) {
      for (var f in e.allTimeLearn) {
        if (f.dayOfWeek < iDayOfWeek ||
            (f.dayOfWeek == iDayOfWeek && f.hourEnd < hour) ||
            (f.dayOfWeek == iDayOfWeek &&
                f.hourEnd == hour &&
                f.minuteEnd < minute)) {
          result.add(Tuple2(e.name, f));
        }
      }
    }

    result.sort((a, b) {
      return a.item2.compareToStartTime(b.item2);
    });

    return result;
  }

  static List<Tuple2<String, TimeSub>> getSubjectsIncomingAtTime(
      String dayOfWeek, int hour, int minute) {
    int iDayOfWeek = TimeSub.strDayToInt(dayOfWeek);
    List<Tuple2<String, TimeSub>> result = [];
    for (var e in listSubject) {
      for (var f in e.allTimeLearn) {
        if (f.dayOfWeek > iDayOfWeek ||
            (f.dayOfWeek == iDayOfWeek && f.hourStart > hour) ||
            (f.dayOfWeek == iDayOfWeek &&
                f.hourStart == hour &&
                f.minuteStart > minute)) {
          Reminder remObj = Reminder();
          remObj.init();
          if (TimeSub.distanceDay(dayOfWeek, TimeSub.intDayToStr(f.dayOfWeek)) >
              remObj.isNoClass) {
            result.add(Tuple2(e.name, f));
          }
        }
      }
    }

    result.sort((a, b) {
      return a.item2.compareToStartTime(b.item2);
    });

    return result;
  }

  static List<Tuple2<String, TimeSub>> getSubjectsDoneAtTimeSameDay(
      String dayOfWeek, int hour, int minute) {
    int iDayOfWeek = TimeSub.strDayToInt(dayOfWeek);
    List<Tuple2<String, TimeSub>> result = [];
    for (var e in listSubject) {
      for (var f in e.allTimeLearn) {
        if ((f.dayOfWeek == iDayOfWeek && f.hourEnd < hour) ||
            (f.dayOfWeek == iDayOfWeek &&
                f.hourEnd == hour &&
                f.minuteEnd < minute)) {
          result.add(Tuple2(e.name, f));
        }
      }
    }

    result.sort((a, b) {
      return a.item2.compareToStartTime(b.item2);
    });

    return result;
  }

  static List<Tuple2<String, TimeSub>> getSubjectsIncomingAtTimeSameDay(
      String dayOfWeek, int hour, int minute) {
    int iDayOfWeek = TimeSub.strDayToInt(dayOfWeek);
    List<Tuple2<String, TimeSub>> result = [];
    for (var e in listSubject) {
      for (var f in e.allTimeLearn) {
        if ((f.dayOfWeek == iDayOfWeek && f.hourStart > hour) ||
            (f.dayOfWeek == iDayOfWeek &&
                f.hourStart == hour &&
                f.minuteStart > minute)) {
          Reminder remObj = Reminder();
          remObj.init();
          if (remObj.isNoClass != 0) {
            return [];
          }
          result.add(Tuple2(e.name, f));
        }
      }
    }

    result.sort((a, b) {
      return a.item2.compareToStartTime(b.item2);
    });

    return result;
  }

  static Subject callInfoSubject(String nameSubject) {
    return listSubject[getSubjectIndexFromName(nameSubject)];
  }

  static String callInfoSubjectStr(String nameSubject) {
    Subject subject = listSubject[getSubjectIndexFromName(nameSubject)];
    return subject.name +
        subject.link +
        subject.learnAt +
        'in day ' +
        subject.allTimeLearn[0].dayOfWeek.toString();
  }

  static List<TimeSub> callTimeByName(String nameSubject) {
    Subject subject = listSubject[getSubjectIndexFromName(nameSubject)];
    List<TimeSub> timelearn = [];
    timelearn.addAll(subject.allTimeLearn);
    return timelearn;
  }

  static String calllearnAtSubjectStr(String nameSubject) {
    Subject subject = listSubject[getSubjectIndexFromName(nameSubject)];
    return subject.learnAt;
  }

  static int getTimeSubjectIdAtTime(TimeSub time) {
    for (var e in listSubject) {
      for (int i = 0; i < e.allTimeLearn.length; i++) {
        if (TimeSub.isInBetween(
            e.allTimeLearn[i], TimeSub.fromSubjectToTime(time), true)) {
          return e.allTimeId[i];
        }
      }
    }
    return -1;
  }

  static bool isAnyLinkFromSubName(String subjectName) {
    int ind = getSubjectIndexFromName(subjectName);
    if (ind == -1) {
      //! หาวิชาไม่เจอ!!!
      return false;
    }
    List<String> links = getLinks(listSubject[ind].link);
    return links.isNotEmpty;
  }

  static String getLinkFromSubName(String subjectName) {
    int ind = getSubjectIndexFromName(subjectName);
    if (ind == -1) {
      //! หาวิชาไม่เจอ!!!
      return "";
    }
    if (isAnyLinkFromSubName(subjectName)) {
      List<String> links = getLinks(listSubject[ind].link);
      return links[0];
    }
    return "";
  }

  static List<String> getLinksFromSubName(String subjectName) {
    int ind = getSubjectIndexFromName(subjectName);
    if (ind == -1) {
      //! หาวิชาไม่เจอ!!!
      return [];
    }
    if (isAnyLinkFromSubName(subjectName)) {
      return getLinks(listSubject[ind].link);
    }
    return [];
  }

  //? TODO STUFF

  static void pushNotiTodo(Todo todo) {
    Reminder remObj = Reminder();
    remObj.init();
    NotificationAPI.showScheduledNotification(
        getID: todo.id,
        getTitle: todo.name,
        getBody: todo.info,
        scheduledDate: DateTime(
                todo.atTime.year,
                todo.atTime.monthOfYear,
                todo.atTime.dayOfMonth,
                todo.atTime.timeHour,
                todo.atTime.timeMinute,
                0)
            .add(Duration(minutes: (remObj.getReminder * -1))));
  }

  static void addTodo(String name, String info, TimeTodo tim) {
    Todo thatTodo = Todo(name, info, tim);
    listTodo.add(thatTodo);
    pushNotiTodo(thatTodo);
    saveFile();
  }

  static int getTodoIndexFromName(String name) {
    for (int i = 0; i < listTodo.length; i++) {
      if (listTodo[i].name.toLowerCase() == name.toLowerCase()) {
        return i;
      }
    }
    return -1;
  }

  static TimeTableStatus removeTodo(String name) {
    int ind = getTodoIndexFromName(name);
    if (ind == -1) {
      //! หาไม่เจอ
      return TimeTableStatus.nameNotExist;
    }
    popNotiSubjectAtTime(listTodo[ind].id);
    listTodo.removeAt(ind);
    saveFile();
    return TimeTableStatus.done;
  }

  static void clearTodo() {
    for (var e in listTodo) {
      popNotiSubjectAtTime(e.id);
    }
    listTodo = [];
    saveFile();
  }

  static TimeTableStatus editTodo(String name, Todo newTodo) {
    int ind = getTodoIndexFromName(name);
    if (ind == -1) {
      //! หาไม่เจอ
      return TimeTableStatus.nameNotExist;
    }
    pushNotiTodo(newTodo);
    listTodo.add(newTodo);
    popNotiSubjectAtTime(listTodo[ind].id);
    listTodo.removeAt(ind);
    saveFile();
    return TimeTableStatus.done;
  }

  static String tToString() {
    String result = "";
    for (var e in listSubject) {
      result += "========== ${e.name} ==========\n";
      result += "ID   : ${e.id}\n";
      result += "link : ${e.link}\n";
      result += "at   : ${e.learnAt}\n";
      result += "Times...\n\t";
      for (var f in e.allTimeLearn) {
        result +=
            "[${TimeSub.intDayToStr(f.dayOfWeek)} at ${f.hourStart}:${f.minuteStart} to ${f.hourEnd}:${f.minuteEnd}] ";
      }
      result += "\n\n";
    }

    for (var e in listTodo) {
      result += "------------ TODO : ${e.name} ------------\n";
      result += "ID   : ${e.id}\n";
      result += "Info : ...\n${e.info}\n";
      result +=
          "when   : ${e.atTime.timeHour}:${e.atTime.timeMinute} <${e.atTime.dayOfMonth}/${e.atTime.monthOfYear}/${e.atTime.year}> \n";
      result += "\n\n";
    }

    return result;
  }

  static void clearAll() {
    clearSubjects();
    clearTodo();
  }

  static void loadFromICSString(String content) {
    ICalendar iCalendar = ICalendar.fromString(content);
    Map<String, int> crtData = {};
    Map<String, String> location = {};
    Map<String, List<DateTime>> dateStSub = {};
    Map<String, List<DateTime>> dateEdSub = {};

    //? gather data;
    for (var e in iCalendar.data) {
      String nameSub = e["summary"];
      DateTime startTime = e["dtstart"].toDateTime();
      DateTime endTime = e["dtend"].toDateTime();
      if (crtData.containsKey(nameSub)) {
        crtData[nameSub] = (crtData[nameSub]! + 1);
        dateStSub[nameSub]!.add(startTime);
        dateEdSub[nameSub]!.add(endTime);
      } else {
        crtData[nameSub] = 1;
        dateStSub[nameSub] = [startTime];
        dateEdSub[nameSub] = [endTime];
      }

      location[nameSub] = e["location"];
    }

    //? if empty, STOP
    if (crtData.isEmpty) {
      return;
    }
    clearAll();

    for (var name in crtData.keys) {
      String? loca = location[name];
      if (crtData[name]! < 5) {
        //? If less than 5 time means Todo or Exam
        for (var todoTime in dateStSub[name]!) {
          todoTime = todoTime.add(const Duration(hours: 7)); //? GMT + 7;
          addTodo(
              name,
              loca!,
              TimeTodo(todoTime.hour, todoTime.minute, todoTime.day,
                  todoTime.month, todoTime.year));
        }
      } else {
        //? Normal Schedule
        Set<TimeSub> timesData = {};

        for (int i = 0; i < dateStSub[name]!.length; i++) {
          var startTime =
              dateStSub[name]![i].add(const Duration(hours: 7)); //? GMT + 7;
          var endTime =
              dateEdSub[name]![i].add(const Duration(hours: 7)); //? GMT + 7;
          timesData.add(TimeSub(TimeSub.intDayToStr(startTime.weekday),
              startTime.hour, startTime.minute, endTime.hour, endTime.minute));
        }
        addSubject(Subject(name, "", loca!, []));
        for (var tim in timesData) {
          addTimeToSubject(name, tim);
        }
      }
    }
  }
}
