import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> init(BuildContext context) async {
    if (!_initialized) {
      _firebaseMessaging.getToken().then((token) => {
            //if the token changed or new send it to server
            print("FirebaseMessaging token: $token")
          });

      var initializationSettingsAndroid =
          new AndroidInitializationSettings('@mipmap/ic_launcher');

      var initializationSettingsIOS = IOSInitializationSettings();
      var initializationSettingsMAC = MacOSInitializationSettings();
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
          macOS: initializationSettingsMAC);

      _localNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: onSelectNotification);

      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, alert: true, badge: true));
      _firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings setting) {
        print('IOS Setting Registered');
      });

      _firebaseMessaging.configure(
        onMessage: onMessage,
        onResume: onResume,
        onLaunch: onLaunch,
      );
      _initialized = true;
    }
  }

  Future<void> onMessage(Map<String, dynamic> message) async {
    print('>>> onMessage: $message');
    String title = message['notification']['title'];
    String body = message['notification']['body'];
    print('Title : $title - Body $body');
    showNotification(title, body);
  }

  Future<void> onResume(Map<String, dynamic> message) async {
    print('>>> onResume: $message');
  }

  Future<void> onLaunch(Map<String, dynamic> message) async {
    print('>>> onLaunch :$message');
  }

  Future onSelectNotification(String message) async {
    print('Message clicked : $message');
  }

  void showNotification(String title, String body) async {
    await _demoNotification(title, body);
  }

  Future<void> _demoNotification(String title, String body) async {
    String _channelId = "com.tera.store";
    String _channelName = "Tera Store";
    String _channelDesc = "E-commerce online store";

    var androidChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDesc,
        importance: Importance.max,
        playSound: true,
        priority: Priority.high,
        showWhen: true,
        autoCancel: true,
        visibility: NotificationVisibility.public);

    var iOSChannelSpecifics = IOSNotificationDetails();
    var channelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iOSChannelSpecifics);
    await _localNotificationsPlugin.show(1995, title, body, channelSpecifics);

    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
    );
  }
}
