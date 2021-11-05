import 'package:better_vote/controllers/UserController.dart';
import 'package:flutter/material.dart';

class NotificationsTabPage extends StatefulWidget {
  NotificationsTabPage({Key key}) : super(key: key);
  @override
  State<NotificationsTabPage> createState() => NotificationsTabState();
}

class NotificationsTabState extends State<NotificationsTabPage> {
  final user = UserController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          builder: notificationsTabBuilder, future: user.canFindProfileData()),
    );
  }

  Widget notificationsTabBuilder(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
      const TextStyle optionStyle =
          TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
      return Center(
        child: Text(
          'Index 3: Notifications',
          style: optionStyle,
        ),
      );
    }
    if (snapshot.hasError) return Text("An error occurred Notifications data.");

    return CircularProgressIndicator();
  }
}
