import 'Ballot.dart';
import 'Poll.dart';
import 'User.dart';

class StarBallot extends Ballot {
  // an array who's index corresponds to the choice at the same index in the _choices array from the Ballot parent class' poll
  // the value at the index is the score of the choice
  List<int> _vote;

  StarBallot(User voter, Poll poll) : super(voter, poll) {
    _vote = List<int>.filled(poll.getNumberOfChoices(), 0, growable: false);
  }

  void setVote(int choice, int score) {
    _vote[choice] = score;
  }

  List<int> getVote() {
    return _vote;
  }
}
