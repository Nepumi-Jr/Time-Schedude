import 'subject.dart';
import 'dart:convert';
import 'TimeSub.dart';
import 'dart:io';
// TODO : Don't forget about storage stuff
//import 'storage.dart';

class TimeTable {
  // static late String name;
  //static late String link;
  //static late String learnAt;
  //static late List allTimeLearn;
  static List<Subject> listSubject = [];
  static int numSubjectDelete = 1000;
  static int numListSubjectDelete = 1000;
  // TODO : Don't forget to save idCounter
  static int idCounter = 0;

  //TimeTable

  static void saveSubject() {
    String jsonText = jsonEncode(listSubject);
    print(jsonText);
    // TODO : Don't forget about storage stuff
    //Storage.writeSubject(jsonText);
  }

  static void loadSubject() async {
    //String jsonText = await Storage.readSubject();
    // listSubject = []
    // List listSomething = jsonDecode(jsonText);
    // for (var e in listSomething) {
    //   listSubject.add(Subject.fromJson(e));
    // }
  }

  void insertSubject() {}

  static void addSubject(Subject subject) {
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

  static void addTimeToSubject(String subjectName, TimeSub newTime) {
    int ind = getSubjectIndexFromName(subjectName);
    if (ind == -1) {
      //! หาวิชาไม่เจอ ควย!!!
    }
    listSubject[ind].allTimeLearn.add(newTime);
    listSubject[ind].allTimeId.add(listSubject[ind].getHashTime(newTime));
  }

  static void removeSubject(String subjectName) {
    int ind = getSubjectIndexFromName(subjectName);
    listSubject.removeAt(ind);
  }

  static void removeSubjectTime(String subjectName, TimeSub tim) {
    int ind = getSubjectIndexFromName(subjectName);
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
    }
    listSubject[ind].allTimeLearn.removeAt(timInd);
  }

  static void editSubject(String subjectOldName, Subject theNewSubject) {
    int ind = getSubjectIndexFromName(subjectOldName);
    theNewSubject.id = listSubject[ind].id;
    theNewSubject.allTimeId = listSubject[ind].allTimeId;
    theNewSubject.allTimeLearn = listSubject[ind].allTimeLearn;

    listSubject.removeAt(ind);
    listSubject.add(theNewSubject);
  }

  static void editSubjectTime(
      String subjectName, TimeSub oldTime, TimeSub newTime) {
    removeSubjectTime(subjectName, oldTime);
    addTimeToSubject(subjectName, newTime);
  }

  static bool isDuplicatedWithSubject(TimeSub tim) {
    for (var e in listSubject) {
      for (var f in e.allTimeLearn) {
        if (TimeSub.isDuplicatedTime(f, tim)) {
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

  static String callInfoSubject(Subject subject) {
    return subject.name +
        subject.link +
        subject.learnAt +
        'in day ' +
        subject.allTimeLearn[0].dayOfWeek.toString();
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

    return result;
  }
}
