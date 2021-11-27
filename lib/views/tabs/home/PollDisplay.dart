import 'package:better_vote/helper/profilePics.dart';
import 'package:flutter/material.dart';
import 'package:better_vote/models/Poll.dart';
import 'package:better_vote/helper/demoValues.dart';
import 'package:better_vote/views/tabs/home/forms/VoteInAPollForm.dart';

class PollDisplay extends StatelessWidget {
  final Poll poll;
  const PollDisplay(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0.5,iconTheme: IconThemeData(color: Color(0xFF00b764)),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _PostDetails(poll),
                _Post(poll),
                _Instructions(poll),
                _VotingForm(poll)
              ],
            ),
          ),
        ),
      )
    );
  }
}

class _Post extends StatelessWidget {
  final Poll poll;
  const _Post(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[_PostTitleAndSummary(poll)],
    ));
  }
}

class _PostTitleAndSummary extends StatelessWidget {
  final Poll poll;
  const _PostTitleAndSummary(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = poll.getTitle();
    final String summary = poll.getQuestion();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Text(title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(summary, style: TextStyle(fontSize: 14)),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

/* For later use if we want to do post images
class _PostImage extends StatelessWidget {
  const _PostImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 2, child: Image.asset(DemoValues.userImage));
  }
}
*/

class _PostDetails extends StatelessWidget {
  final Poll poll;
  const _PostDetails(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 5),
        _UserImage(),
        SizedBox(width: 10),
        _UserName(poll.getCreator().getUsername()),
        _PostTime(poll.getStartTime()),
        SizedBox(width: 5)
      ],
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

class _UserImage extends StatelessWidget {
  const _UserImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: CircleAvatar(
        backgroundImage: NetworkImage(ProfilePics.janedoeProfilePic),
      ),
    );
  }
}

class _PostTime extends StatelessWidget {
  final String startTime;
  const _PostTime(this.startTime, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //To use later
    var timeDifference =
        DateTime.now().difference(DateTime.parse(startTime)).inHours;

    return Expanded(
      flex: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(DemoValues.postTime),
        ],
      ),
    );
  }
}

class _Instructions extends StatelessWidget {
  final Poll poll;
  const _Instructions(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[_VotingSystemAndInstructions(poll)],
        ));
  }
}

class _VotingSystemAndInstructions extends StatelessWidget {
  final Poll poll;
  const _VotingSystemAndInstructions(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String votingSystem = poll.getVotingSystem();
    String votingInstructions = _getVotingInstructions(votingSystem);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(
                "Voting System: " + votingSystem,
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold
                )
              ),
              SizedBox(
                width: 5
              ),
              ButtonTheme(padding: EdgeInsets.all(0), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, child: 
              TextButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height*0.75,
                        color: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text('Modal BottomSheet'),
                              ElevatedButton(
                                child: const Text('Close BottomSheet'),
                                onPressed: () => Navigator.pop(context),
                              )
                            ],
                          )
                        )
                      );
                    }
                  );
                },
                child: 
                  Text(
                    "Learn More",
                    style: TextStyle(
                      fontSize: 12, 
                      color: Color(0xFF00b764)
                    ),
                  )
              ),)
            ]
          ),
          //SizedBox(height: 5),
          // Text("Instructions: " + votingInstructions,
          //     style: TextStyle(fontSize: 14)),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  String _getVotingInstructions(String votingSystem) {
    String rcv = "RCV";
    String star = "STAR";
    String plurality = "Plurality";

    if (votingSystem == rcv) {
      return "These are the instructions for RCV. This is how you vote in a RCV poll. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
    } else if (votingSystem == star) {
      return "These are the instructions for STAR. This is how you vote in a STAR poll.";
    } else if (votingSystem == plurality) {
      return "These are the instructions for Plurality. This is how you vote in a Plurality poll.";
    }
  }
}

class _VotingForm extends StatelessWidget {
  final Poll poll;
  const _VotingForm(this.poll, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[VoteInAPollForm(poll)],
        ));
  }
}
