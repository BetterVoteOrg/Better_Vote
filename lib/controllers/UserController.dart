import 'dart:convert';
import 'package:better_vote/network/NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/Poll.dart';

class User {
  var _userdata;
  List<Poll> _createdPolls = [];
  List<Poll> _votedPolls = [];

  User();

  String getUsername() {
    return _userdata["user_name"];
  }

  String getEmail() {
    return _userdata["email"];
  }

  String getCreatedAt() {
    return _userdata["created_at"];
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

  Future<bool> canFindProfileData() async {
    final _jsonWebToken = await FlutterSecureStorage().read(key: "jwt");
    Map<String, dynamic> _payloadFromToken =
        getpayloadFromToken(_jsonWebToken.split(".")[1]);
    String response =
        await NetworkHandler("/api/users/" + _payloadFromToken["user_id"])
            .fetchData();
    _userdata = json.decode(response);
    print(_userdata);

    return _userdata["user_id"] != null;

    // if (data.statusCode == 200) {r
    //   _username = data["user_name"];
    //   print(data);
    // }
  }
}
