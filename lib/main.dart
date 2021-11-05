import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'network/NetworkHandler.dart';
import 'views/Homepage.dart';
import 'views/Intro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isBusy = false;
  bool _isLoggedIn = false;
  String _jsonWebToken;
  Map<String, dynamic> _payloadFromToken;

  Future<String> get getJsonWebTokenOrEmpty async {
    const storage = FlutterSecureStorage();
    var _jsonWebToken = await storage.read(key: "jwt");
    if (_jsonWebToken == null) return "";
    return _jsonWebToken;
  }

  void handleLoading(snapshot) {
    _isBusy = !snapshot.hasData;
  }

  void handleData(snapshot) {}
  bool tokenIsAuthorized(Map<String, dynamic> _payloadFromToken) {
    return DateTime.fromMillisecondsSinceEpoch(_payloadFromToken["exp"] * 1000)
        .isAfter(DateTime.now());
  }

  void handleLogging(snapshot) {
    if (snapshot.data != "") {
      _jsonWebToken = snapshot.data.toString();
      List<String> jwtList = _jsonWebToken.split(".");
      if (jwtList.length >= 3) {
        _payloadFromToken = getpayloadFromToken(jwtList[1]);
        if (tokenIsAuthorized(_payloadFromToken)) {
          _isLoggedIn = true;
        }
      }
    }
  }

  Widget handleDisplay(context, snapshot) {
    handleLoading(snapshot);
    handleLogging(snapshot);
    if (_isBusy) return const CircularProgressIndicator();
    if (_isLoggedIn) return HomePage();
    return IntroPage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BetterVote',
        theme: ThemeData(
          primaryColor: Color(0xFF008037),
        ),
        localizationsDelegates: [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''),
          Locale('es', ''),
          Locale('fa', ''),
          Locale('fr', ''),
          Locale('ja', ''),
          Locale('pt', ''),
          Locale('sk', ''),
          Locale('pl', ''),
        ],
        home: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          // minimum: EdgeInsets.all(16.0),
          // maintainBottomViewPadding: true,
          child: FutureBuilder(
              future: getJsonWebTokenOrEmpty, builder: handleDisplay),
        ));
  }

  // ···
}

// import 'package:flutter/material.dart';r

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
