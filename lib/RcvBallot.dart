import 'Ballot.dart';
import 'Poll.dart';
import 'User.dart';

class RcvBallot extends Ballot {
  List<int> _vote;

  RcvBallot(User voter, Poll poll) : super(voter, poll) {
    _vote = List<int>.filled(poll.getNumberOfChoices(), 0, growable: false);
  }
}
