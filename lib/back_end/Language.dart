import 'package:localstorage/localstorage.dart';

class Language {
  final LocalStorage storage = LocalStorage('Time-Schedude');
  static final Language _singleton = Language._internal();
  Language._internal();

  factory Language() {
    return _singleton;
  }

  Future<void> init() async {
    await storage.ready.then((value) {
      _currLang = storage.getItem('language') ?? 'thai';
    });
  }

  String _currLang = 'thai';
  String get getLanguage => _currLang;
  set setLanguage(String s) => storage.ready.then(
        (value) {
          storage.setItem('language', s);
          _currLang = s;
        },
      );

  final Map<String, Map<String, String>> _Lang = {
    'thai': {
      'classScheTitle': 'ตารางเรียน',
      'editClassTitle': 'แก้ไขวิชา',
      'addClassTitle': 'เพิ่มวิชา',
      'addWorkTitle': 'เพิ่มงาน',
      'addTitle': 'เพิ่ม',
      'finishedTitle': 'จบการเรียน',
      'upNextTitle': 'วิชาต่อไป',
      'listToDoTitle': 'รายการที่จะทำ',
      'monTitle': 'วันจันทร์',
      'tuesTitle': 'วันอังคาร',
      'wednesTitle': 'วันพุธ',
      'thursTitle': 'วันพฤหัสบดี',
      'friTitle': 'วันศุกร์',
      'satTitle': 'วันเสาร์',
      'sunTitle': 'วันอาทิตย์',
      'classNameTitle': 'ชื่อวิชา',
      'linkTitle': 'ลิ้งเรียน',
      'onSiteTitle': 'เรียนที่',
      'studyHoursTitle': 'เวลาเรียน',
      'toTitle': 'ถึง',
      'dateClassTitle': 'วันที่เรียน',
      'settingTitle': 'การตั้งค่า',
      'notifiTitle': 'แจ้งเตือน',
      'dailyNotTitle': '',
      'classNotTitle': '',
      'alarmTitle': 'แจ้งเตือนก่อน',
      'langTitle': 'ภาษา',
      'resetTitle': 'รีเซ็ต',
      'classInfo': 'ข้อมูลรายวิชา',
      'applyTitle': 'ยืนยัน',
      'doneTile': 'เสร็จสิ้น',
      'joinTitle': 'เข้าร่วม',
      'editTitle': 'แก้ไข',
    },
    'eng': {
      'classScheTitle': 'Class Schedule',
      'editClassTitle': 'Edit Classwork',
      'addClassTitle': 'Add Classwork',
      'addWorkTitle': 'add work',
      'addTitle': 'add',
      'finishedTitle': 'Finished',
      'upNextTitle': 'Up Next',
      'listToDoTitle': 'List to do',
      'monTitle': 'Monday',
      'tuesTitle': 'Tuesday',
      'wednesTitle': 'Wednesday',
      'thursTitle': 'Thursday',
      'friTitle': 'Friday',
      'satTitle': 'Saterday',
      'sunTitle': 'Sunday',
      'classNameTitle': 'Class Name',
      'linkTitle': 'Link',
      'onSiteTitle': 'On-Site at',
      'studyHoursTitle': 'Study hours',
      'toTitle': 'to',
      'dateClassTitle': 'Date Class:',
      'settingTitle': 'Settings',
      'notifiTitle': 'Notification',
      'dailyNotTitle': 'Daily Notification',
      'classNotTitle': 'Class Notification',
      'alarmTitle': 'Alarm Clock',
      'langTitle': 'Language',
      'resetTitle': 'reset',
      'classInfo': 'Class infomation',
      'applyTitle': 'Apply',
      'doneTile': 'Done',
      'joinTitle': 'Join',
      'editTitle': 'Edit',
    },
  };
  String? get(String key) => _Lang[_currLang]![key];
}
