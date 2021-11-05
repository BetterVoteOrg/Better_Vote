import 'dart:convert';

import 'package:better_vote/models/Poll.dart';
import 'package:better_vote/models/User.dart';
import 'package:better_vote/network/NetworkHandler.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PollController {
  PollController();
  String _pollPath = "/api/users/me/created-polls";

  Future<dynamic> getUserCreatedPolls() async {
    var response = await NetworkHandler(_pollPath).fetchData();
    Map<String, dynamic> allPolls = json.decode(response);
    User pollCreator = User(allPolls);
    // print(allPolls["created_polls"]);

    // allPolls["created_polls"].forEach((key, value) {
    //   print(key);
    // });
    // print(allPolls);

    List<dynamic> pollsRaw = allPolls["created_polls"];
    // print(pollsRaw.toList()[0]);
    List<Poll> polls = [];

    pollsRaw.toList().forEach((rawPollData) {
      Map<String, dynamic> data = rawPollData;
      polls.add(Poll(pollCreator, data));
      // Poll(pollCreator, data["poll_title"], data["start_time"],
      //     data["end_time"], data["prompt"], data["vote_system"]);
    });

    return polls;
  }
}
