import 'package:better_vote/Poll.dart';

class User {
  String _username;
  String _password;

  List<Poll> _createdPolls = [];
  List<Poll> _votedPolls = [];

  User(String username, String password) {
    this._username = username;
    this._password = password;
  }

  String getUsername() {
    return _username;
  }

  String getPasswork() {
    return _password;
  }

  List<Poll> getCreatedPolls() {
    return _createdPolls;
  }

  void addCreatedPoll(Poll poll) {
    _createdPolls.add(poll);
  }

  List<Poll> getVotedPolls() {
    return _votedPolls;
  }

  void addVotedPoll(Poll poll) {
    _votedPolls.add(poll);
  }
}
