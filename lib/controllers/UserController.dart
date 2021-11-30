import 'dart:convert';
import 'package:better_vote/controllers/PollController.dart';
import 'package:better_vote/models/Poll.dart';
import 'package:better_vote/models/User.dart';
import 'package:better_vote/network/NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserController {
  var _userdata;

  UserController();

  Future<User> findProfileData() async {
    var _jsonWebToken = await FlutterSecureStorage().read(key: "jwt");
    Map<String, dynamic> _payloadFromToken =
        getpayloadFromToken(_jsonWebToken.split(".")[1]);
    String response =
        await NetworkHandler("/api/users/" + _payloadFromToken["user_id"])
            .fetchData();
    _userdata = json.decode(response);
    return User(_userdata);
  }

  Map<String, dynamic> getLoggedInUserJsonData() {
    return _userdata;
  }

  Future<dynamic> getProfileData(User user) async {
    String response =
        await NetworkHandler("/api/users/" + user.getUserID()).fetchData();
    return json.decode(response);
  }

  Future<List<Poll>> getUserParticipatedPolls(User user) async {
    String _pollPath = "/api/users/me/participated-polls";
    try {
      var response = await NetworkHandler(_pollPath).fetchData();
      List<dynamic> selectionsWithPolls = json.decode(response);
      List<Poll> polls = [];

      for (var rawPollData in selectionsWithPolls.toList()) {
        Map<String, dynamic> pollData = rawPollData['poll'];
        Poll poll = Poll(user, pollData);
        int value = await PollController().getNumberOfVotes(poll);
        poll.setNumVoters(value);
        polls.add(poll);
      }
      // selectionsWithPolls.toList().forEach((rawPollData) {
      //   Map<String, dynamic> pollData = rawPollData['poll'];
      //   polls.add(Poll(user, pollData));
      // });
      return polls;
    } catch (error) {
      throw error;
    }
  }

  Future<List<Poll>> getUserCreatedPolls(User user) async {
    String _pollPath = "/api/users/${user.getUserID()}/created-polls";
    return await _organizedData(_pollPath, user);
  }

  Future<List<Poll>> _organizedData(String _pollPath, User user) async {
    try {
      var response = await NetworkHandler(_pollPath).fetchData();
      List<dynamic> allPolls = json.decode(response);
      List<Poll> polls = [];

      for (var rawPollData in allPolls.toList()) {
        Map<String, dynamic> pollData = rawPollData;
        Poll poll = Poll(user, pollData);
        int value = await PollController().getNumberOfVotes(poll);
        poll.setNumVoters(value);
        polls.add(poll);
      }
      // allPolls.toList().forEach((rawPollData) {
      //   Map<String, dynamic> pollData = rawPollData;
      //   polls.add(Poll(user, pollData));
      // });

      return polls;
    } catch (error) {
      throw error;
    }
  }
}
