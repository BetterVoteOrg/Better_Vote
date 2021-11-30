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
    return Expanded(
        //width: MediaQuery.of(context).size.width,
        child: Column(
      children: <Widget>[
        FutureBuilder(
          builder: (context, snapshot) {
            if (!snapshot.hasError) {
              if (snapshot.hasData) if (snapshot.data) {
                return Center(
                  child: Results(poll),
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

  Widget _getVotingForm() {
    String rcv = "RCV";
    String star = "STAR";
    String plurality = "PLURALITY";
    final String votingSystem = poll.getVotingSystem();
    //debugPrint("here we are");

    if (votingSystem == rcv) {
      return RCVForm(poll);
    } else if (votingSystem == star) {
      return STARForm(poll);
    } else if (votingSystem == plurality) {
      return PLURALITYForm(poll);
    }
  }
}
