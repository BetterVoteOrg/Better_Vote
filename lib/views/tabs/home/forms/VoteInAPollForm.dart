import 'package:flutter/material.dart';
import 'package:better_vote/models/Poll.dart';
import 'PLURALITY/PLURALITYForm.dart';
import 'RCV/RCVForm.dart';
import 'STAR/STARForm.dart';

class VoteInAPollForm extends StatelessWidget {
  final Poll poll;
  const VoteInAPollForm(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        //width: MediaQuery.of(context).size.width,
        child: Column(
      children: <Widget>[_getVotingForm()],
    ));
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
