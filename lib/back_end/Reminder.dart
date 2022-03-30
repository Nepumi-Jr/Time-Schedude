import 'package:localstorage/localstorage.dart';

class Reminder {
  final LocalStorage storage = LocalStorage('Time-Schedude');
  static final Reminder _singleton = Reminder._internal();
  Reminder._internal();

  factory Reminder() {
    return _singleton;
  }

  Future<void> init() async {
    await storage.ready.then((value) {
      _reminder = storage.getItem('reminder') ?? 30;
      _noClass = storage.getItem('noClass') ?? 0;
      _notification = storage.getItem('notification') ?? true;
    });
  }

  int _reminder = 30;
  int get getReminder => _reminder;
  set setReminder(int i) => storage.ready.then(
        (value) {
          storage.setItem('reminder', i);
          _reminder = i;
        },
      );

  int _noClass = 0;
  int get isNoClass => _noClass;
  set setNoClass(int i) => storage.ready.then(
        (value) {
          storage.setItem('noClass', i);
          _noClass = i;
        },
      );

  Future<void> dayPast() async {
    await storage.ready.then((value) {
      _reminder = storage.getItem('reminder') ?? 30;
      _noClass = storage.getItem('noClass') ?? 0;
      _notification = storage.getItem('notification') ?? true;
    });
  }

  bool _notification = true;
  bool get getNotification => _notification;
  set setNotification(bool i) => storage.ready.then(
        (value) {
          storage.setItem('notification', i);
          _notification = i;
        },
      );
}
