import 'package:better_vote/helper/profilePics.dart';
import 'package:flutter/material.dart';
import 'package:better_vote/models/Poll.dart';
import 'package:better_vote/helper/demoValues.dart';
import 'package:better_vote/views/tabs/home/forms/VoteInAPollForm.dart';
import 'package:better_vote/helper/descriptionTextWidgetV2.dart';
import 'package:badges/badges.dart';

import 'Post.dart';

class PollDisplay extends StatelessWidget {
  final Poll poll;
  const PollDisplay(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          iconTheme: IconThemeData(color: Color(0xFF00b764)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _PostDetails(poll),
                  Post(
                    poll,
                    child: _PostTitleAndSummary(poll),
                  ),
                  _Instructions(poll),
                  poll.getStatus() == 'ACTIVE'
                      ? _VotingForm(poll) //CHANGE BACK
                      : _Results(poll)
                ],
              ),
            ),
          ),
        ));
  }
}

// class _Post extends StatelessWidget {
//   final Poll poll;
//   const _Post(this.poll, {Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Row(
//       children: <Widget>[_PostTitleAndSummary(poll)],
//     ));
//   }
// }

class _PostTitleAndSummary extends StatelessWidget {
  final Poll poll;
  const _PostTitleAndSummary(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = poll.getTitle();
    final String status = poll.getStatus();
    final String summary = poll.getQuestion();
    final String image = poll.getImageUrl();
    final int numVotes = poll.getNumberOfVotes();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Text(title,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              handlePollStatus(status),
              if (status != 'ENDED')
                Wrap(
                  children: [
                    Text("$numVotes",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(numVotes == 1 ? "Vote" : "Votes")
                  ],
                )
            ],
          ),
          SizedBox(height: 10),
          image == 'no image' || image == null
              ? Container()
              : AspectRatio(
                  aspectRatio: 18.0 / 13.0,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        image,
                        fit: BoxFit.fill,
                      )),
                ),
          SizedBox(height: 10),
          //Text(summary, style: TextStyle(fontSize: 14)),
          //Text(summary, style: TextStyle(fontSize: 14)),
          DescriptionTextWidget(text: summary),
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
        UserImage(url: poll.getCreator().getAvatar()),
        SizedBox(width: 10),
        _UserName(poll.getCreator().getUsername()),
        PostTime(poll.getStartTime()),
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

// ignore: must_be_immutable
class UserImage extends StatelessWidget {
  String url = ProfilePics.janedoeProfilePic;
  UserImage({Key key, String url}) : super(key: key) {
    if (url != null) this.url = url;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: CircleAvatar(
        backgroundImage: NetworkImage(this.url, scale: 0.5),
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
    votingSystem.toLowerCase();
    String votingInstructions = _getVotingInstructions(votingSystem);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(children: [
            Text("Voting System: " + votingSystem,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(width: 5),
            ButtonTheme(
              padding: EdgeInsets.all(0),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(25.0),
                            topRight: const Radius.circular(25.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              Row(children: [
                                Text("How to Vote",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ]),
                              Divider(
                                  color: Color(0xFF00b764),
                                  height: 40,
                                  thickness: 1,
                                  indent: 1,
                                  endIndent: 1),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                          _getVotingInstructions(votingSystem)))
                                ],
                              )
                            ],
                          )),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Learn More",
                    style: TextStyle(fontSize: 12, color: Color(0xFF00b764)),
                  )),
            )
          ]),
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
    String plurality = "PLURALITY";

    if (votingSystem == rcv) {
      return "Rank your favorite choice with “1”, your second favorite with “2”, and so on. You must rank at least your first choice. No choice may be given the same rank. Although you do not need to rank all the choices, doing so may result in your vote not being considered in later rounds.";
    } else if (votingSystem == star) {
      return "Give each choice a score between zero and five, where a higher score means you like the choice more. Not all choices need to be scored, but at least one does. Choices that are left unscored will receive a score of zero. You may give multiple choices the same score, but note that giving both choices that make it to the runoff the same score will be interpreted as a vote of no preference between the two.";
    } else if (votingSystem == plurality) {
      return "Select your favorite choice. You must select exactly one choice.";
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

class _Results extends StatelessWidget {
  final Poll poll;
  const _Results(this.poll, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int numVotes = poll.getNumberOfVotes();
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text("Choices",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          SizedBox(height: 10),
          Align(
              alignment: Alignment.centerLeft,
              child: Wrap(children: [_Choices(poll)])),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Results",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
              Wrap(
                children: [
                  Text("$numVotes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(numVotes == 1 ? "Vote" : "Votes")
                ],
              )
            ],
          ),
          Divider(
              color: Color(0xFF00b764),
              height: 20,
              thickness: 1,
              indent: 1,
              endIndent: 1),
          Row(
            children: [
              Text("Winner",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          SizedBox(height: 10),
          Row(children: [
            Flexible(child: Text(" ${poll.getResults().winner}")),
          ]),
          SizedBox(height: 20),
          Row(
            children: [
              Text("Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          SizedBox(height: 10),
          Row(children: [
            Flexible(
                child:
                    Text("${poll.getResults().analysis.replaceAll("\n", " ")}"))
          ])
        ],
      ),
    );
  }
}

class _Choices extends StatelessWidget {
  final Poll poll;
  const _Choices(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> choices = poll.getChoices();
    //List<dynamic> choices = ["superlong", "thisistheiha","fdsahfjudskhaf","fkdlsjifkldshak", "fdjkshfkdjushafjkhsiuahjkda", "kfdsjhkafhds", "salfjdklsfjals", "fldksjlafj", "fdjksfhdjskahfk", "kslafj", "djksdf", "jdsfk", "djkshf", "fdjshfjskha"];
    //int numChoices = choices.length;

    return Wrap(
        children: choices
            .map<Widget>((choices) => Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
                  child: Badge(
                      toAnimate: false,
                      shape: BadgeShape.square,
                      badgeColor: Colors.white,
                      borderSide: BorderSide(color: Color(0xFF00b764)),
                      borderRadius: BorderRadius.circular(100),
                      badgeContent: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(choices,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 12,
                              )))),
                ))
            .toList());
  }
}
