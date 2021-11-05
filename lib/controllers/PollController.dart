import 'dart:convert';
import 'package:better_vote/models/Poll.dart';
import 'package:better_vote/models/User.dart';
import 'package:better_vote/network/NetworkHandler.dart';

class PollController {
  PollController();

  Future<dynamic> getUserCreatedPolls() async {
    String _pollPath = "/api/users/me/created-polls";
    var response = await NetworkHandler(_pollPath).fetchData();
    Map<String, dynamic> allPolls = json.decode(response);
    User pollCreator = User(allPolls);
    List<dynamic> pollsRaw = allPolls["created_polls"];
    List<Poll> polls = [];

    pollsRaw.toList().forEach((rawPollData) {
      Map<String, dynamic> data = rawPollData;
      polls.add(Poll(pollCreator, data));
    });

    return polls;
  }

  Future<dynamic> getPublicPolls() async {
    try {
      print("Fetching polls");
      var response = await NetworkHandler("/api/polls/public").fetchData();
      List<dynamic> allPolls = json.decode(response);
      List<Poll> polls = [];
      allPolls.toList().forEach((rawPollData) {
        User pollCreator = User(rawPollData["created_by"]);
        Map<String, dynamic> data = rawPollData;
        polls.add(Poll(pollCreator, data));
      });
      return polls;
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> createNewPoll() async {
    //To implement
  }
}
