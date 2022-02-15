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
      'finishedTitle': 'จบการเรียน',
    },
    'eng': {
      'classScheTitle': 'Class Schedule',
      'editClassTitle': 'Edit Classwork',
      'addClassTitle': 'Add Classwork',
      'finishedTitle': 'Finished',
    },
  };
  String? get(String key) => _Lang[_currLang]![key];
}
