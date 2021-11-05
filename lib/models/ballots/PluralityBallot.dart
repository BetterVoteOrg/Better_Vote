import 'package:better_vote/controllers/UserController.dart';

import 'Ballot.dart';
import '../../models/Poll.dart';

class PluralityBallot extends Ballot {
  // this is a List because it needs to override getVote() from Ballot.dart. It could otherwise
  // just be an int because the List will always have a length of 1 who's value
  // corresponds to the index of the _choices array from the Ballot parent class' poll
  List<int> _vote;

  PluralityBallot(User voter, Poll poll) : super(voter, poll) {
    _vote = List<int>.filled(1, -1, growable: false);
  }

  void setVote(int choice) {
    _vote[0] = choice;
  }

  @override
  List<int> getVote() {
    return _vote;
  }
}
