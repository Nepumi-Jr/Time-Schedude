import 'TimeTodo.dart';
import 'subject.dart';
import 'Todo.dart';
import 'dart:convert';
import 'TimeSub.dart';
import 'dart:io';
// TODO : Don't forget about storage stuff
//import 'storage.dart';

class TimeTable {
  static List<Subject> listSubject = [];
  static List<Todo> listTodo = [];
  // TODO : Don't forget to save idCounter
  static int idCounter = 0;

  //TimeTable

  static void saveSubject() {
    // String subjectJson = jsonEncode(listSubject);
    // Storage.writeFile("subject.json", subjectJson);

    // Storage.writeFile("id.dat", "$idCounter");

    // String todoJson = jsonEncode(listTodo);
    // Storage.writeFile("todo.json", todoJson);
  }

  static void loadSubject() async {
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
    saveSubject();
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
  }

  static void removeSubject(String subjectName) {
    int ind = getSubjectIndexFromName(subjectName);
    if (ind == -1) {
      //! หาวิชาไม่เจอ!!!
      return;
    }
    listSubject.removeAt(ind);
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

  static String callSubjectThisTime(TimeSub time) {
    for (var e in listSubject) {
      for (var f in e.allTimeLearn) {
        if (TimeSub.isInBetween(f, TimeSub.fromSubjectToTime(time), true)) {
          return e.name;
        }
      }
    }
    return "-";
  }

  static void callInfoTable() {
    //? Bruh
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
  }

  static void editTodo(String name, Todo newTodo) {
    int ind = getTodoIndexFromName(name);
    if (ind == -1) {
      //! หาไม่เจอ
      return;
    }
    listTodo.add(newTodo);
    listTodo.removeAt(ind);
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
}
