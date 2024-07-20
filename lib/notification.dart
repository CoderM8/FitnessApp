import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_ui/constant.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  if (kDebugMode) {
    print('HELLO NOTIFICATION BACKGROUND CALLBACK ${notificationResponse.payload}');
  }
}

/// BACKGROUND NOTIFICATION
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('HELLO NOTIFICATION BACKGROUND ${message.toMap()}');
  }
}

final StreamController<String?> selectNotificationStream = StreamController<String?>.broadcast();

void _configureSelectNotificationSubject() {
  selectNotificationStream.stream.listen((String? payload) async {
    Map<String, dynamic> str = jsonDecode(payload!);
    if (kDebugMode) {
      print('HELLO NOTIFICATION CLICK $str');
    }
  });
}

class LocalNotificationService {
  //Singleton pattern
  static final LocalNotificationService _notificationService = LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _notificationService;
  }

  static String? selectedNotificationPayload;

  LocalNotificationService._internal();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const String channelId = '123';
  static const channelName = 'Diary';
  static const channelDescription = 'FlutterNotification';
  final StreamController<Map<String, dynamic>> controllerPayload = StreamController<Map<String, dynamic>>();

  Stream<Map<String, dynamic>> get streamPayload => controllerPayload.stream;

  static NotificationAppLaunchDetails? notificationAppLaunchDetails;
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    /// INITIALIZE MESSAGING
    NotificationSettings settings = await messaging.requestPermission(alert: true, announcement: false, badge: true, carPlay: false, criticalAlert: false, provisional: false, sound: true);

    if (kDebugMode) {
      print('HELLO NOTIFICATION STATUS ${settings.authorizationStatus}');
    }
    messaging.subscribeToTopic('all_users');

    /// FOREGROUND NOTIFICATION
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print('HELLO NOTIFICATION FOREGROUND ${message.toMap()}');
      }
      await showNotifications(message);
    });

    /// BACKGROUND ON CLICK NOTIFICATION
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print('HELLO NOTIFICATION OPEN APP ${message.data}');
      }
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload = notificationAppLaunchDetails!.notificationResponse?.payload;
    }

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("@mipmap/launcher_icon");

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    const DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
        requestSoundPermission: true,
        defaultPresentSound: true,
        requestAlertPermission: true,
        defaultPresentAlert: true,
        requestBadgePermission: false,
        defaultPresentBadge: false,
        defaultPresentBanner: false,
        defaultPresentList: false,
        requestCriticalPermission: false,
        requestProvisionalPermission: false);
    //for IOS Foreground Notification
    await messaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    final implementationAndroid = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    final implementationIOS = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    await implementationAndroid?.requestNotificationsPermission();
    await implementationIOS?.requestPermissions(alert: true, badge: true, sound: true);
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        selectNotificationStream.add(notificationResponse.payload);
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    _configureSelectNotificationSubject();
  }

  static Future<void> showNotifications(RemoteMessage message) async {
    await flutterLocalNotificationsPlugin.show(
      message.messageId.hashCode,
      message.notification!.title,
      message.notification!.body,
      const NotificationDetails(
          android: AndroidNotificationDetails(channelId, channelName, icon: "@mipmap/launcher_icon", priority: Priority.high, importance: Importance.max, enableVibration: true, ticker: 'ticker'),
          iOS: DarwinNotificationDetails(
              // when app in foreground show notification if both [true]
              presentBanner: true,
              presentList: true)),
      payload: jsonEncode(message.data),
    );
  }

  static Future<void> zonedScheduleNotification(DateTime dateTime, Map<String, dynamic> toMap) async {
    final DateTime date = dateTime;
    if (date.isAfter(tz.TZDateTime.now(tz.local))) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse(toMap['id'].toString()),
        'Pro Fitness',
        "Improve your fitness with ${toMap['title']}",
        payload: jsonEncode(toMap),
        tz.TZDateTime.from(date, tz.local),
        const NotificationDetails(
            android: AndroidNotificationDetails(channelId, channelName),
            iOS: DarwinNotificationDetails(
                // when app in foreground show notification if both [true]
                presentBanner: true,
                presentList: true)),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    } else {
      showToast('Date is past');
      if (kDebugMode) {
        print('HELLO SCHEDULE NOTIFICATION DATE IS PAST $date TZDate: ${tz.TZDateTime.now(tz.local)}');
      }
    }
  }

  /// pending scheduled notifications
  static Future<List<PendingNotificationRequest>> pendingNotification() async {
    return await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  static Future<void> cancel(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  void close() {
    controllerPayload.close();
  }
}
