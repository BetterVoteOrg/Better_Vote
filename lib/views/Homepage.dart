import 'package:better_vote/controllers/UserController.dart';
import 'package:better_vote/models/User.dart';
import 'package:better_vote/network/NetworkHandler.dart';
import 'package:better_vote/views/tabs/createpoll/CreatePollTab.dart';
import 'package:better_vote/views/tabs/explore/ExploreTab.dart';
import 'package:better_vote/views/tabs/home/HomeTab.dart';
import 'package:better_vote/views/tabs/notifications/NotificationsTab.dart';
import 'package:better_vote/views/tabs/profile/ProfileTab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  State<HomePage> createState() => HomeState();
}

class HomeState extends State<HomePage> {
  int _selectedIndex = 0;
  UserController userController;
  HomeState();
  // var _jsonWebToken;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    List<Widget> _screenOptions = <Widget>[
      HomeTabPage(),
      ExploreTabPage(),
      CreatePollTabPage(),
      NotificationsTabPage(),
      SafeArea(child: ProfileTabPage()),
    ];

    Widget handleScreenDisplay(User user) {
      return _screenOptions[_selectedIndex];
    }

    Widget navBar() {
      return BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            //backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
            //backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create Poll',
            //backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            //backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            //backgroundColor: Colors.white,
          ),
        ],
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color(0xFF00b764),
        onTap: _onItemTapped,
      );
    }

    return Scaffold(
      // appBar: AppBar(title: const Text("Home")),
      body: FutureBuilder(
          future: UserController().findProfileData(),
          builder: (context, snapshot) => snapshot.hasData
              ?
              //snapshot.data is the json web token.
              Center(
                  child: handleScreenDisplay(snapshot.data),
                )
              : snapshot.hasError
                  ? const Text("An error occurred logging in.")
                  : const Center(
                      child: CircularProgressIndicator(),
                    )),

      bottomNavigationBar: navBar(),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     setState(() {
      //       _selectedIndex = 2;
      //     });
      //   },
      // ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
