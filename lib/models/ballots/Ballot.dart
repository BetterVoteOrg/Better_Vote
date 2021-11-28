import '../../models/Poll.dart';
abstract class Ballot {
  Poll _poll;

  Ballot( Poll poll) {
    this._poll = poll;
  }

  Poll getPoll() {
    return _poll;
  }

  List<int> getVote();
}
