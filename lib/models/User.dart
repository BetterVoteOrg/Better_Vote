import 'package:better_vote/controllers/UserController.dart';
import '../models/Poll.dart';

class User {
  UserController controller = UserController();
  String _userName;
  String _email;
  String _createdAt;
  String _userId;
  String _userAvatar;
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
    return await controller.getUserCreatedPolls(this);
  }

  Future<List<Poll>> getVotedPolls() async {
    return await controller.getUserParticipatedPolls(this);
  }
}
