import 'package:better_vote/controllers/UserController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Poll.dart';

class User {
  UserController controller = UserController();
  String _userName;
  String _email;
  String _createdAt;
  String _userId;
  String _userAvatar;
  int _pollsCreated = 0;
  int _pollsVoted = 0;
  User(Map<String, dynamic> data) {
    _userName = data["user_name"];
    _email = data["email"];
    _createdAt = data["created_at"];
    _userId = data["user_id"];
    _userAvatar = data["user_avatar"];
  }

  String getUsername() {
    return _userName;
  }

  String getEmail() {
    return _email;
  }

  int getnumPollsVoted() {
    return _pollsVoted;
  }

  int getnumPollsCreated() {
    return _pollsCreated;
  }

  String getAvatar() {
    return _userAvatar;
  }

  String getUserID() {
    return _userId;
  }

  String getCreatedAt() {
    return _createdAt;
  }

  Future<List<Poll>> getCreatedPolls() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    _pollsCreated = prefs.getInt("numPollsCreated");
    List<Poll> polls = await controller.getUserCreatedPolls(this);
    return polls;
  }

  Future<List<Poll>> getVotedPolls() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    _pollsVoted = prefs.getInt("numPollsVoted");
    List<Poll> polls = await controller.getUserParticipatedPolls(this);
    return polls;
  }
}
