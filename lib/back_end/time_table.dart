import 'package:tuple/tuple.dart';

import 'time_todo.dart';
import 'subject.dart';
import 'todo.dart';
import 'dart:convert';
import 'time_sub.dart';

import 'dart:io';
import 'package:icalendar_parser/icalendar_parser.dart';
// TODO : Don't forget about storage stuff
//import 'storage.dart';

class TimeTable {
  static List<Subject> listSubject = [];
  static List<Todo> listTodo = [];
  static int idCounter = 0;

  //TimeTable

  static void saveFile() {
    // String subjectJson = jsonEncode(listSubject);
    // Storage.writeFile("subject.json", subjectJson);

    // Storage.writeFile("id.dat", "$idCounter");

    // String todoJson = jsonEncode(listTodo);
    // Storage.writeFile("todo.json", todoJson);
  }

  static void loadFile() async {
    // String subjectJson = await Storage.readFile("subject.json");
    // loadSubjectsFromJson(subjectJson);

    // idCounter = int.parse(await Storage.readFile("id.dat"));

    // String todoJson = await Storage.readFile("todo.json");
    // loadTodoFromJson(todoJson);
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

  static void addSubject(Subject subject) {
    //? Check name
    if (isExistName(subject.name)) {
      //! Duplicated name
      return;
    }
    //? Check Times
    for (var e in subject.allTimeLearn) {
      if (isOverlapAnySubject(e)) {
        //! Overlap Time
        return;
      }
    }
    subject.id = idCounter;
    subject.doGenTimeId();
    listSubject.add(subject);
    saveFile();
    idCounter++;
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

  static void addTimeToSubject(String subjectName, TimeSub newTime) {
    int ind = getSubjectIndexFromName(subjectName);
    if (ind == -1) {
      //! หาวิชาไม่เจอ ควย!!!
      return;
    }
    if (isOverlapAnySubject(newTime)) {
      //! Overlap Time
      return;
    }
    listSubject[ind].allTimeLearn.add(newTime);
    listSubject[ind].allTimeId.add(listSubject[ind].getHashTime(newTime));
    saveFile();
  }

  static void removeSubject(String subjectName) {
    int ind = getSubjectIndexFromName(subjectName);
    if (ind == -1) {
      //! หาวิชาไม่เจอ!!!
      return;
    }
    listSubject.removeAt(ind);
    saveFile();
  }

  static void removeSubjectTime(String subjectName, TimeSub tim) {
    int ind = getSubjectIndexFromName(subjectName);
    if (ind == -1) {
      //! หาวิชาไม่เจอ!!!
      return;
    }
    int timInd = -1;
    for (int i = 0; i < listSubject[ind].allTimeLearn.length; i++) {
      if (listSubject[ind].allTimeLearn[i].dayOfWeek == tim.dayOfWeek &&
          listSubject[ind].allTimeLearn[i].hourStart == tim.hourStart &&
          listSubject[ind].allTimeLearn[i].minuteStart == tim.minuteStart) {
        timInd = i;
        break;
      }
    }
    if (timInd == -1) {
      //! อย่าหลอน
      return;
    }
    listSubject[ind].allTimeLearn.removeAt(timInd);
    saveFile();
  }

  static void clearSubjects() {
    listSubject = [];
    idCounter = 0;
    saveFile();
  }

  static void editSubject(String subjectOldName, Subject theNewSubject) {
    int ind = getSubjectIndexFromName(subjectOldName);
    Subject oldSubj = listSubject[ind];
    listSubject.removeAt(ind);
    //? Check name
    if (isExistName(theNewSubject.name)) {
      //! Duplicated name
      listSubject.add(oldSubj);
      return;
    }
    //? Check Times
    for (var e in theNewSubject.allTimeLearn) {
      if (isOverlapAnySubject(e)) {
        //! Overlap Time
        listSubject.add(oldSubj);
        return;
      }
    }

    theNewSubject.id = oldSubj.id;
    theNewSubject.allTimeId = oldSubj.allTimeId;
    theNewSubject.allTimeLearn = oldSubj.allTimeLearn;

    listSubject.add(theNewSubject);
    saveFile();
  }

  static void editSubjectTime(
      String subjectName, TimeSub oldTime, TimeSub newTime) {
    removeSubjectTime(subjectName, oldTime);
    if (isOverlapAnySubject(newTime)) {
      //! Overlap Time
      addTimeToSubject(subjectName, oldTime);
      return;
    }
    addTimeToSubject(subjectName, newTime);
    saveFile();
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
          return Tuple2(e.name, f);
        }
      }
    }
    return Tuple2("-", TimeSub("Monday", 0, 0, 0, 0));
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
                f.minuteEnd < minute)) result.add(Tuple2(e.name, f));
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
                f.minuteStart > minute)) result.add(Tuple2(e.name, f));
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
                f.minuteEnd < minute)) result.add(Tuple2(e.name, f));
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
                f.minuteStart > minute)) result.add(Tuple2(e.name, f));
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

  //? TODO STUFF
  static void addTodo(String name, String info, TimeTodo tim) {
    listTodo.add(Todo(name, info, tim));
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

  static void removeTodo(String name) {
    int ind = getTodoIndexFromName(name);
    if (ind == -1) {
      //! หาไม่เจอ
      return;
    }
    listTodo.removeAt(ind);
    saveFile();
  }

  static void clearTodo() {
    listTodo = [];
    saveFile();
  }

  static void editTodo(String name, Todo newTodo) {
    int ind = getTodoIndexFromName(name);
    if (ind == -1) {
      //! หาไม่เจอ
      return;
    }
    listTodo.add(newTodo);
    listTodo.removeAt(ind);
    saveFile();
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
