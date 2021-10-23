import 'package:better_vote/Poll.dart';
import 'package:better_vote/User.dart';

class Ballot {
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
}
