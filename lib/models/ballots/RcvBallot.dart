import 'package:better_vote/controllers/UserController.dart';

import 'Ballot.dart';
import '../../models/Poll.dart';

class RcvBallot extends Ballot {
  // an array who's index corresponds to the choice at the same index in the _choices array from the Ballot parent class' poll
  // the value at the index is the rank of the choice
  List<int> _vote;

  RcvBallot(User voter, Poll poll) : super(voter, poll) {
    _vote = List<int>.filled(
        poll.getNumberOfChoices(), poll.getNumberOfChoices() + 1,
        growable: false);
  }

  void setVote(int choice, int rank) {
    _vote[choice] = rank;
  }

  List<int> getVote() {
    return _vote;
  }
}
