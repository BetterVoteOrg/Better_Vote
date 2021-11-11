import 'package:better_vote/controllers/UserController.dart';
import 'package:better_vote/models/Poll.dart';
import 'package:better_vote/models/User.dart';
import 'package:flutter/material.dart';

class ProfileTabPage extends StatefulWidget {
  // ProfileTabPage( {Key key}) : super(key: key)
  @override
  State<ProfileTabPage> createState() => ProfileState();
}

class ProfileState extends State<ProfileTabPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          builder: profileBuilder, future: UserController().findProfileData()),
    );
  }

  Widget profileBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    const darkGreen = const Color(0xFF008037);
    String dropdownValue = 'Active';
    if (snapshot.hasData) {
      User _user = snapshot.data;
      return Scaffold(
          body: Column(
        children: [
          Container(
            //Top User Info Bar
            alignment: Alignment.topCenter,
            color: darkGreen,
            height: 275,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // 2 Top Buttons
                children: [
                  IconButton(
                      alignment: Alignment.topLeft,
                      onPressed: onPressed,
                      icon: Icon(Icons.arrow_back, size: 50)),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.black,
                          padding: EdgeInsets.fromLTRB(0, 15, 15, 0),
                          textStyle: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      onPressed: onPressed,
                      child: Text("EDIT"))
                ],
              ),
              Icon(Icons.account_circle_outlined, size: 150),
              Text(
                _user.getUsername(),
                style: const TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 2,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("# Polls Created: ", textScaleFactor: 1.1),
                  Text("# Polls Participated in: ", textScaleFactor: 1.1)
                ]),
              ),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: darkGreen,
                        border: Border(
                            top: BorderSide(width: 4, color: Color(0xFF000000)),
                            left:
                                BorderSide(width: 0, color: Color(0xFF000000)),
                            right:
                                BorderSide(width: 3, color: Color(0xFF000000)),
                            bottom: BorderSide(
                                width: 4, color: Color(0xFF000000)))),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            primary: Colors.black,
                            padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                            textStyle: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        onPressed: onPressed,
                        child: Text("Polls I created"))),
              ),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: darkGreen,
                          border: Border(
                              top: BorderSide(
                                  width: 4, color: Color(0xFF000000)),
                              left: BorderSide(
                                  width: 3, color: Color(0xFF000000)),
                              right: BorderSide(
                                  width: 0, color: Color(0xFF000000)),
                              bottom: BorderSide(
                                  width: 4, color: Color(0xFF000000)))),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              primary: Colors.black,
                              padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                              textStyle: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          onPressed: onPressed,
                          child: Text("Polls I voted in"))))
            ],
          ),
          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            alignment: Alignment.topLeft,
            child: Row(children: [
              Text("Sort By: ",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              DropdownButton<String>(
                value: dropdownValue,
                onChanged: (value) {
                  setState(() {
                    dropdownValue = value;
                    print(dropdownValue);
                  });
                },
                items: <String>['Active', 'Closed', 'Third']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)));
                }).toList(),
                underline: Container(
                  height: 1,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ]),
          ),

          //
          //Sort by dropdown
          Column(
              //ONLY THING LEFT TO IMPLEMENT

              //Help to display polls user has participated in or created

              // FutureBuilder(
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       List<Poll> polls = snapshot.data;
              //       return ListView.builder(
              //           itemCount: polls.length,
              //           shrinkWrap: true,
              //           itemBuilder: (BuildContext context, int index) {
              // Widget to make
              //             return PollThingy(polls[index]);
              //           });
              //     }

              //     if (snapshot.hasError)
              //       return Text("An error occurred fetching polls.");
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   },
              //   future: _user.getCreatedPolls(), OR _user.getParticipatePolls()
              // )

              ) // Polls
        ],
      ));
    }
    if (snapshot.hasError) return Text("An error occurred fetching user data.");

    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void onPressed() {
    print("Tried to go back");
  }
}
