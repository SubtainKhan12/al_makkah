import 'package:al_makkah/SplashScreen/splashScreen.dart';
import 'package:al_makkah/Utilities/Colors/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // static final GlobalKey<NavigatorState> navigatorKey =
  //     GlobalKey<NavigatorState>();

  initLocalNotification() async {
    const initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: notificationResponse,
        onDidReceiveBackgroundNotificationResponse: notificationResponse);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
        alert: false, badge: false, sound: false);
    const android = AndroidNotificationDetails('amcs', 'alMakkah',
        enableVibration: true,
        playSound: true,
        priority: Priority.high,
        importance: Importance.max);
    const iOS = DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    const platform = NotificationDetails(android: android, iOS: iOS);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      flutterLocalNotificationsPlugin.show(message.hashCode,
          message.notification!.title, message.notification!.body, platform,
          payload: message.data["type"]);
      // if (DriverCustomScreen.driverCustomKey.currentState != null) {
      //   DriverCustomScreen.driverCustomKey.currentState!.getdatafuc();
      // }
      // if (DriverOrderScreen.driverOrderKey.currentState != null) {
      //   DriverOrderScreen.driverOrderKey.currentState!.getdatafuc();
      // }
    });
    FirebaseMessaging.onMessageOpenedApp.listen(onOpenApp);
    FirebaseMessaging.instance.getInitialMessage().then(onOpenApp);
  }

  static Future<void Function(NotificationResponse)?> notificationResponse(
      NotificationResponse response) async {
    // openAppNavigator(response.payload);
    return null;
  }

  onOpenApp(RemoteMessage? response) async {
    if (response != null) {
      // openAppNavigator(response.data['type']);
    }
    return null;
  }

  Future<NotificationSettings> requestPermission() async {
    return await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        sound: true,
        provisional: false);
  }
  @override
  void initState() {
    requestPermission().then((value) {
      initLocalNotification();
      FirebaseMessaging.instance.subscribeToTopic("alMakkah");
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorsUtils.baigeColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}


