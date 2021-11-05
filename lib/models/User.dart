import '../models/Poll.dart';

class User {
  List<Poll> _createdPolls = [];
  List<Poll> _votedPolls = [];
  String _userName;
  String _email;
  String _createdAt;
  String _userId;
  User(Map<String, dynamic> data) {
    _userName = data["user_name"];
    _email = data["email"];
    _createdAt = data["created_at"];
    _userId = data["user_id"];
  }

  String getUsername() {
    return _userName;
  }

  String getEmail() {
    return _email;
  }

  String getUserID() {
    return _userId;
  }

  String getCreatedAt() {
    return _createdAt;
  }

  List<Poll> getCreatedPolls() {
    return _createdPolls;
  }

  List<Poll> getVotedPolls() {
    return _votedPolls;
  }
}
