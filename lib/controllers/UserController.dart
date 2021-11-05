import 'dart:convert';
import 'package:better_vote/models/User.dart';
import 'package:better_vote/network/NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/Poll.dart';

class UserController {
  var _userdata;
  List<Poll> _createdPolls = [];
  List<Poll> _votedPolls = [];

  UserController();

  void addCreatedPoll(Poll poll) {
    _createdPolls.add(poll);
  }

  List<Poll> getVotedPolls() {
    return _votedPolls;
  }

  void addVotedPoll(Poll poll) {
    _votedPolls.add(poll);
  }

  Future<User> canFindProfileData() async {
    var _jsonWebToken = await FlutterSecureStorage().read(key: "jwt");
    Map<String, dynamic> _payloadFromToken =
        getpayloadFromToken(_jsonWebToken.split(".")[1]);
    String response =
        await NetworkHandler("/api/users/" + _payloadFromToken["user_id"])
            .fetchData();
    _userdata = json.decode(response);
    return User(_userdata);
  }

  Map<String, dynamic> getLoggedInUserData() {
    return _userdata;
  }

  Future<dynamic> getProfileData(User user) async {
    String response =
        await NetworkHandler("/api/users/" + user.getUserID()).fetchData();
    return json.decode(response);
  }
}
