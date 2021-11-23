
import 'package:flutter/material.dart';
import 'package:better_vote/models/Poll.dart';
//import 'package:better_vote/helper/descriptionTextWidgetV2.dart';
import 'package:better_vote/helper/demoValues.dart';
//import 'package:flutter/semantics.dart';
import 'package:better_vote/views/tabs/forms/VoteInAPollForm.dart';

class PollDisplay extends StatelessWidget{
  final Poll poll;
  const PollDisplay(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        //title: Text(poll.getTitle()),
        backgroundColor: Color(0xFF008037),
      ),
        
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[_PostDetails(poll), _Post(poll), _Instructions(poll), _VotingForm(poll)],
          ),
        ),
      ),

    );
}
}

class _Post extends StatelessWidget {
  final Poll poll;
  const _Post(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //flex: 3,
      child: Row(
        children: <Widget>[_PostTitleAndSummary(poll)],
      )
    );

  }
}

class _PostTitleAndSummary extends StatelessWidget {
  final Poll poll;
  const _PostTitleAndSummary(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final TextStyle titleTheme = Theme.of(context).textTheme.title;
    //final TextStyle summaryTheme = Theme.of(context).textTheme.body1;
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
          //new DescriptionTextWidget(text: summary),
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
        _UserImage(),
        _UserName(poll.getCreator().getUsername()),
        _PostTime(poll.getStartTime())
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
        backgroundImage: AssetImage(DemoValues.userImage),
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
      )
    );

  }
}

class _VotingSystemAndInstructions extends StatelessWidget {
  final Poll poll;
  const _VotingSystemAndInstructions(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final String votingSystem = poll.getVotingSystem();
    //final String votingSystem = "STAR";
    //debugPrint(votingSystem);
    String votingInstructions = _getVotingInstructions(votingSystem);
    //debugPrint(votingInstructions);
    
    return Expanded(
      //flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("Voting System: " + votingSystem,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text("Instructions: " + votingInstructions, style: TextStyle(fontSize: 14)),
          SizedBox(height: 20),
        ],
      ),
    );

  }

  String _getVotingInstructions(String votingSystem) {
    
    String rcv = "RCV";
    String star = "STAR";
    String plurality = "Plurality";

    //debugPrint("called voting instructions");
    //debugPrint(votingSystem);
    if(votingSystem == rcv){
      //debugPrint("made it here");
      return "These are the instructions for RCV. This is how you vote in a RCV poll. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
    }else if (votingSystem == star){
      return "These are the instructions for STAR. This is how you vote in a STAR poll.";
    }else if (votingSystem == plurality){
      return "These are the instructions for Plurality. This is how you vote in a Plurality poll.";
    }

  }
}

class _VotingForm extends StatelessWidget {
  final Poll poll;
  const _VotingForm(this.poll, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context){

    //final String votingSystem = poll.getVotingSystem();

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[VoteInAPollForm(poll)],
      )
    );

  }


}
