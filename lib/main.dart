import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:ocr_medical_department/api_setup/injection_container.dart';
import 'package:ocr_medical_department/glucose/glucose_chart_weekly.dart';
import 'package:ocr_medical_department/glucose/glucose_chart_weekly_alternative.dart';
import 'glucose/glucose_chart1_weekly.dart';
import 'glucose/glucose_chart_daily.dart';
import 'list_by_date/blood_pressure_bar_chart.dart';
import 'list_by_date/blood_pressure_chart_weekly.dart';
import 'ocr/my_home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.pinkAccent,
        importance: NotificationImportance.High,
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic Group')
    ],
    debug: true,
  );
  bool isAllowedSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> apiResponse = {
      "Week 1": {"avg_level": 7.2, "category": "High"},
      "Week 2": {"avg_level": 5.0, "category": "Low"},
      "Week 3": {"avg_level": 0.0, "category": "NA"},
      "Week 4": {"avg_level": 6.0, "category": "Normal"},
    };

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'OCR Screen'),
    );
  }
}
