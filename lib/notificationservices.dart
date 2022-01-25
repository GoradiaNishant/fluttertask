import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationServices{

  static final _notification=FlutterLocalNotificationsPlugin();
  static final onNotification=BehaviorSubject<String?>();

  static NotificationDetails _notificationDetails(){
    return const NotificationDetails(
        android: AndroidNotificationDetails(
            'channel_id',
            'channel_name',
            importance: Importance.max
        ),
        iOS: IOSNotificationDetails());
  }

  static Future init({bool initSchedule=false})async{
    tz.initializeTimeZones();

    const setting=InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: IOSInitializationSettings()
    );

    await _notification.initialize(setting,onSelectNotification: (payload)async{
      onNotification.add(payload);
    });
  }

  static Future showNotification({
    int id=0,
    String? tittle,
    String? body,
    String? payload,
  })async=>_notification.show(id, tittle, body, _notificationDetails(),payload: payload);

  static Future showScheduledNotification({
    int id=0,
    String? tittle,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  })async{
    _notification.zonedSchedule(id, tittle, body,
        tz.TZDateTime.from(scheduledDate,tz.local),
        _notificationDetails(),payload: payload,androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }
}