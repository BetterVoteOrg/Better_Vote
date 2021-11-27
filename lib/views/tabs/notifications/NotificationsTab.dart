import 'dart:io';

import 'package:better_vote/controllers/UserController.dart';
import 'package:better_vote/network/FileHandler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NotificationsTabPage extends StatefulWidget {
  NotificationsTabPage({Key key}) : super(key: key);
  @override
  State<NotificationsTabPage> createState() => NotificationsTabState();
}

class NotificationsTabState extends State<NotificationsTabPage> {
  final _userController = UserController();
  FileHandler fileHandler = FileHandler();
  File image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          builder: notificationsTabBuilder,
          //Replace with method to fetch notifications
          future: _userController.findProfileData()),
    );
  }

  Widget notificationsTabBuilder(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
      const TextStyle optionStyle =
          TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
      return Center(
        child: Container(
          child: Column(
            children: [
              image == null ? Text('No Image Showing') : Image.file(image),
              ElevatedButton(
                child: Text("Add Image"),
                onPressed: () async {
                  XFile xfile = await fileHandler.getImageFromGallery();
                  setState(() {
                    image = File(xfile.path);
                  });
                },
              )
            ],
          ),
        ),
      );
    }
    if (snapshot.hasError) return Text("An error occurred Notifications data.");
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
