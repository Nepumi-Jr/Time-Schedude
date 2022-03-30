// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sendlink_application/front_end/settingpage.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationAPI {
  static final _fltLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel ID',
        'chanel Name',
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    final Androidinit = AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSinit = IOSInitializationSettings();
    final innitializationSetting =
        InitializationSettings(android: Androidinit, iOS: IOSinit);
    initializeTimeZones();
    await _fltLocalNotificationsPlugin.initialize(innitializationSetting,
        onSelectNotification: (payload) async {
      onNotification.add(payload);
    });
  }

  static Future removeId(int getID) async {
    _fltLocalNotificationsPlugin.cancel(getID);
  }

  static Future removeAll() async {
    _fltLocalNotificationsPlugin.cancelAll();
  }

  static Future showWeeklyNotification({
    int? getID,
    String? getTitle,
    String? getBody,
    String? payload,
    String? getDay,
    Time? getTime,
  }) async {
    Map<dynamic, dynamic> day = {
      'Sunday': DateTime.sunday,
      'Monday': DateTime.monday,
      'Tuesday': DateTime.tuesday,
      'Wednesday': DateTime.wednesday,
      'Thursday': DateTime.thursday,
      'Friday': DateTime.friday,
      'Saturday': DateTime.saturday
    };

    _fltLocalNotificationsPlugin.zonedSchedule(
      getID!,
      getTitle,
      getBody,
      scheduledWeekly(getTime!, days: [day[getDay]]),
      await _notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: toggleNotificationValue,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  static Future showScheduledNotification({
    int? getID,
    String? getTitle,
    String? getBody,
    String? payload,
    required DateTime scheduledDate,
  }) async =>
      _fltLocalNotificationsPlugin.zonedSchedule(
        getID!,
        getTitle,
        getBody,
        tz.TZDateTime.from(scheduledDate, tz.getLocation('Asia/Bangkok')),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: toggleNotificationValue,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

  static tz.TZDateTime scheduledWeekly(Time time, {required List<int> days}) {
    tz.TZDateTime scheduledDate = _scheduledDaily(time);

    while (!days.contains(scheduledDate.weekday)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }
    return scheduledDate;
  }

  static tz.TZDateTime _scheduledDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.getLocation('Asia/Bangkok'),
        now.year, now.month, now.day, time.hour, time.minute, time.second);
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(Duration(days: 1))
        : scheduledDate;
  }
}
