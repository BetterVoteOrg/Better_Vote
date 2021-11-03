import 'Ballot.dart';
import 'Poll.dart';
import 'controllers/UserController.dart';

class PluralityBallot extends Ballot {
  // corresponds to the index of the _choices array from the Ballot parent class' poll
  int _vote;

  PluralityBallot(User voter, Poll poll) : super(voter, poll) {}

  void setVote(int choice) {
    _vote = choice;
  }
}
