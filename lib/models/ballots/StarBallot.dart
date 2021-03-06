import 'Ballot.dart';
import '../../models/Poll.dart';

class StarBallot extends Ballot {
  // an array who's index corresponds to the choice at the same index in the _choices array from the Ballot parent class' poll
  // the value at the index is the score of the choice
  List<int> _vote;

  StarBallot(Poll poll) : super(poll) {
    this._vote =
        List<int>.filled(poll.getNumberOfChoices(), 0, growable: false);
  }

  void setVote(int choice, int score) {
    this._vote[choice] = score;
  }

  @override
  List<int> getVote() {
    return this._vote;
  }
}
