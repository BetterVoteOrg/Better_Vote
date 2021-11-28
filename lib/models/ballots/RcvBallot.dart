import '../User.dart';
import 'Ballot.dart';
import '../../models/Poll.dart';

class RcvBallot extends Ballot {
  // an array who's index corresponds to the choice at the same index in the _choices array from the Ballot parent class' poll
  // the value at the index is the rank of the choice
  List<int> _RANKS;

  RcvBallot(Poll poll) : super(poll) {
    this._RANKS= List<int>.filled(
        poll.getNumberOfChoices(), poll.getNumberOfChoices() + 1,
        growable: false);
  }

  void setVote(int choice, int rank) {
    this._RANKS[choice] = rank;
  }

  @override
  List<int> getVote() {
    return this._RANKS;
  }
}
