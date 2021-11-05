import '../../models/Poll.dart';
import '../User.dart';

abstract class Ballot {
  User _voter;
  Poll _poll;

  Ballot(User voter, Poll poll) {
    this._voter = voter;
    this._poll = poll;
  }

  User getVoter() {
    return _voter;
  }

  Poll getPoll() {
    return _poll;
  }

  List<int> getVote();
}
