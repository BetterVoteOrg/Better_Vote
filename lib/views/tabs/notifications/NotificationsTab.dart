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
      return DefaultTabController(
        length: 2,
        child: new Scaffold(
          body: new NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  title: Text("Notifications", style: TextStyle(color: Colors.black),),
                  centerTitle: true,
                  floating: true,
                  pinned: true,
                  snap: true,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.settings_outlined,
                        color: Color(0xFF00b764),
                      ),
                      onPressed: () {
                        // do something
                      },
                    )
                  ],
                  bottom: new TabBar(
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Color(0xFF00b764),
                    labelColor: Color(0xFF00b764),
                    isScrollable: false,
                    tabs: [
                      new Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: new Tab(text: 'All'),
                      ),
                      new Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: new Tab(text: 'My Polls'),
              ),
                    ],
                  ),
                ),
              ];
            },
            body: new TabBarView(
              children: <Widget>[
                ExampleTab(),
                ExampleTab(),
              ],
            ),
          ),
        ),
      );
    }
    if (snapshot.hasError) return Text("An error occurred Notifications data.");
    return Center(
      child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF00b764))),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ExampleTab() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        /* physics: ScrollPhysics(),
        child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment.topCenter,
                          image: NetworkImage(data),
                          fit: BoxFit.cover),
                    )),
                ListView.builder(
                  itemCount: 10,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 90,
                              width: 200,
                              decoration: BoxDecoration(),
                              child: PollInfo(),
                            ),
                            Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      alignment: Alignment.topLeft,
                                      image: NetworkImage(
                                          "https://cdn.vox-cdn.com/thumbor/__NxmQB8LwWlOch596eOaPhXaFg=/0x0:2845x1500/920x613/filters:focal(1216x499:1670x953):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/69972613/EN_SQdGame_Main_PlayGround_Horizontal_RGB_PRE.0.jpeg"),
                                      fit: BoxFit.fitHeight),
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            )), */
      );
    });
  }

}
