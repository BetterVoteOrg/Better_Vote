import 'package:better_vote/controllers/UserController.dart';
import 'package:better_vote/helper/demoValues.dart';
import 'package:better_vote/helper/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ExploreTabPage extends StatefulWidget {
  ExploreTabPage({Key key}) : super(key: key);
  @override
  State<ExploreTabPage> createState() => ExploreTabState();
}

class ExploreTabState extends State<ExploreTabPage> {
  //Replace with appropriate controller
  final _userController = UserController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          builder: exploreTabBuilder,
          future: _userController.findProfileData()),
    );
  }

  Widget exploreTabBuilder(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
      return DefaultTabController(
        length: 5,
        child: new Scaffold(
          body: new NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  title: Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    height: 30,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 36.0,
                        width: double.infinity,
                        child: CupertinoTextField(
                          keyboardType: TextInputType.text,
                          placeholder: 'Search',
                          placeholderStyle: TextStyle(
                            color: Colors.black38,
                            fontSize: 14.0,
                            fontFamily: 'Brutal',
                          ),
                          prefix: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 6.0, 0.0, 6.0),
                            child: Icon(
                              Icons.search,
                              color: Colors.black38,
                              size: 16,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.black12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  floating: true,
                  pinned: true,
                  snap: true,
                  bottom: new TabBar(
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Color(0xFF00b764),
                    labelColor: Color(0xFF00b764),
                    isScrollable: true,
                    tabs: <Tab>[
                      new Tab(text: "For you", ),
                      new Tab(text: "Trending"),
                      new Tab(text: "Sports"),
                      new Tab(text: "Entertainment"),
                      new Tab(text: "Random"),
                    ],
                  ),
                ),
              ];
            },
            body: new TabBarView(
              children: <Widget>[
                ExampleTab(semaAwards),
                ExampleTab(squidgame),
                ExampleTab(sports),
                ExampleTab(entertainment),
                ExampleTab(random),
              ],
            ),
          ),
        ),
      );
    }
    if (snapshot.hasError) return Text("An error occurred home data.");
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ExampleTab(Object data) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        physics: ScrollPhysics(),
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
            )),
      );
    });
  }

  Widget PollInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [_UserImage(), _UserName("meep")],
        ),
        Text("Poll Title"),
        Text("Description"),
        Text("Tags")
      ],
    );
  }
}

class _UserImage extends StatelessWidget {
  const _UserImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: CircleAvatar(
        backgroundImage: AssetImage(DemoValues.userImage),
        radius: 10,
      ),
    );
  }
}

class _UserName extends StatelessWidget {
  final username;
  const _UserName(this.username, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(username),
        ],
      ),
    );
  }
}
