import 'dart:html';

import 'package:better_vote/network/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert' show json, base64, ascii;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'CreateAPoll.dart';

Map<String, dynamic> getpayloadFromToken(_jsonWebToken) {
  return json
      .decode(ascii.decode(base64.decode(base64.normalize(_jsonWebToken))));
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  State<HomePage> createState() => HomeState();
}

class HomeState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Explore',
      style: optionStyle,
    ),
    CreateAPoll(),
    Text(
      'Index 3: Notifications',
      style: optionStyle,
    ),
    Text(
      'Index 4: Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Widget userBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        Map<String, dynamic> _payloadFromUserRequest =
            json.decode(snapshot.data);
        print(_payloadFromUserRequest);
        return Center(
          child: Column(
            children: [
              Text("WELCOME"),
              Text("Username:  " + _payloadFromUserRequest["user_name"]),
              Text("Email: " + _payloadFromUserRequest["email"]),
              Text("Account created: " + _payloadFromUserRequest["created_at"]),
            ],
          ),
        );
      }
      if (snapshot.hasError)
        return Text("An error occurred fetching user data.");
      return CircularProgressIndicator();
    }

    Widget displayUserData(String _jsonWebToken) {
      //This payloadFromToken has user id, iat=> date user logged in, iat => jsonwebtoken expiry date
      //Get data using id
      Map<String, dynamic> _payloadFromToken =
          getpayloadFromToken(_jsonWebToken.split(".")[1]);
      return Center(
        child: FutureBuilder(
          future: NetworkHandler("/api/users/" + _payloadFromToken["user_id"])
              .fetchData(),
          builder: userBuilder,
        ),
      );
    }

    return Scaffold(
      // appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
        // FutureBuilder(
        //     future: FlutterSecureStorage().read(key: "jwt"),
        //     builder: (context, snapshot) => snapshot.hasData
        //         ?
        //         //snapshot.data is the json web token.
        //         displayUserData(snapshot.data)
        //         : snapshot.hasError
        //             ? const Text("An error occurred logging in.")
        //             : const CircularProgressIndicator()),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create Poll',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
