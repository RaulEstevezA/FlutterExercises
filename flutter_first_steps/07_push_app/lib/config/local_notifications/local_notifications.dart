import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {

  static Future<void> requestPermissionLocalNotifications() async {
        final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();       
  }

  static Future<void> initializeLocalNotifications() async {
    
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    // TODO Ios

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // TODO iOS
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings
    );
  }

}


