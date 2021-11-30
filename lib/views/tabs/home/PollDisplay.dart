import 'package:better_vote/helper/profilePics.dart';
import 'package:flutter/material.dart';
import 'package:better_vote/models/Poll.dart';
import 'package:better_vote/helper/demoValues.dart';
import 'package:better_vote/views/tabs/home/forms/VoteInAPollForm.dart';
import 'package:better_vote/helper/descriptionTextWidgetV2.dart';

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
                      ? _VotingForm(poll)
                      : Center(
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                    "Poll is not active or has ended. (Specify)"),
                                Text("Winner:"),
                                Text(" ${poll.getResults().winner}"),
                                Text("Analysis: "),
                                Text("${poll.getResults().analysis}")
                              ],
                            ),
                          ),
                        )
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
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Text(title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          handlePollStatus(status),
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
        _UserImage(url: poll.getCreator().getAvatar()),
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
class _UserImage extends StatelessWidget {
  String url = ProfilePics.janedoeProfilePic;
  _UserImage({Key key, String url}) : super(key: key) {
    print(url);
    if (url != null) this.url = url;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: CircleAvatar(
        backgroundImage: NetworkImage(this.url),
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
                        height: MediaQuery.of(context).size.height * 0.9,
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
                                Text("Voting Systems",
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
                              Row(children: [
                                Flexible(
                                    child: Text(
                                        "Explanation of Voting Systems. Just explain why voting systems are important and what voting systems Better Vote offers. Filler Text: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."))
                              ]),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                    "How to vote",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
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
      return "These are the instructions for RCV. This is how you vote in a RCV poll. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Resize Later";
    } else if (votingSystem == star) {
      return "These are the instructions for STAR. This is how you vote in a STAR poll. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Resize later";
    } else if (votingSystem == plurality) {
      return "These are the instructions for Plurality. This is how you vote in a Plurality poll.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Resize later";
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
