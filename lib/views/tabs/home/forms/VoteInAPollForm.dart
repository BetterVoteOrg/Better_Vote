import 'package:better_vote/views/tabs/home/PollDisplay.dart';
import 'package:flutter/material.dart';
import 'package:better_vote/models/Poll.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PLURALITY/PLURALITYForm.dart';
import 'RCV/RCVForm.dart';
import 'STAR/STARForm.dart';

class VoteInAPollForm extends StatelessWidget {
  final Poll poll;
  VoteInAPollForm(this.poll, {Key key}) : super(key: key);
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    var startArr =
        DateTime.parse(poll.getStartTime()).toLocal().toString().split(" ");
    var stopArr = DateTime.parse(poll.getEndTime())
        .toLocal()
        .toLocal()
        .toString()
        .split(" ");
    Widget _getVotingForm() {
      //debugPrint("here we are");

      return Column(
        children: [
          Text("Started ${startArr[0]} at ${startArr[1].substring(0, 5)}"),
          Text("Ends ${stopArr[0]} at ${stopArr[1].substring(0, 5)}"),
          chooseForm()
        ],
      );
    }

    return Expanded(
        //width: MediaQuery.of(context).size.width,
        child: Column(
      children: <Widget>[
        FutureBuilder(
          builder: (context, snapshot) {
            if (!snapshot.hasError) {
              if (snapshot.hasData) if (snapshot.data) {
                return Center(
                  child: Column(
                    children: [
                      if (poll.getStatus() == 'ACTIVE')
                        Text(
                            "Thanks for voting. Poll will end on ${stopArr[0]} at ${stopArr[1].substring(0, 5)}"),
                      if (poll.getStatus() == 'JUST_CREATED')
                        Text(
                            "Poll will start on ${startArr[0]} at ${startArr[1].substring(0, 5)}"),
                      Padding(padding: EdgeInsets.all(20)),
                      Results(poll),
                    ],
                  ),
                );
              }
              return _getVotingForm();
            }
            return Center(
              child: Text("${snapshot.error}"),
            );
          },
          future: checkIfVoted(),
        )
      ],
    ));
  }

  checkIfVoted() async {
    final SharedPreferences prefs = await _prefs;

    List<dynamic> votedPollsIds = prefs.getStringList("votedPollsIds");
    return votedPollsIds.contains(poll.getId());
  }

  Widget chooseForm() {
    String rcv = "RCV";
    String star = "STAR";
    String plurality = "PLURALITY";
    final String votingSystem = poll.getVotingSystem();

    if (votingSystem == rcv) {
      return RCVForm(poll);
    } else if (votingSystem == star) {
      return STARForm(poll);
    } else if (votingSystem == plurality) {
      return PLURALITYForm(poll);
    }

    return Container();
  }
}
