import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    var androidInitilize = AndroidInitializationSettings("appicon");
    var initilizationSettings =
        InitializationSettings(android: androidInitilize);

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    _flutterLocalNotificationsPlugin.initialize(initilizationSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails("channel ID", "Aman",
        importance: Importance.high);

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails);

    // await _flutterLocalNotificationsPlugin.show(
    //     0, "Task", "You created a Task", generalNotificationDetails,
    //     payload: "Task data");

    var scheduledTime = DateTime.now().add(Duration(seconds: 5));

    _flutterLocalNotificationsPlugin.schedule(
        1,
        "Task",
        "Schedule time notification",
        scheduledTime,
        generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
        onPressed: _showNotification,
        child: Text("Click Me"),
      )),
    );
  }

  Future notificationSelected(dynamic payload) async {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(content: Text("notification click $payload")));
  }
}
