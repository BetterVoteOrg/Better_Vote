import 'dart:convert';
import 'package:better_vote/models/Poll.dart';
import 'package:better_vote/models/User.dart';
import 'package:better_vote/network/NetworkHandler.dart';

class PollController {
  PollController();

  Future<dynamic> getUserCreatedPolls(User user) async {
    String _pollPath = "/api/users/${user.getUserID()}/created-polls";
    var response = await NetworkHandler(_pollPath).fetchData();
    List<Map<String, dynamic>> allPolls = json.decode(response);
    // User pollCreator = User(allPolls);
    // List<dynamic> pollsRaw = allPolls["created_polls"];
    List<Poll> polls = [];
    allPolls.toList().forEach((rawPollData) {
      Map<String, dynamic> pollData = rawPollData;
      polls.add(Poll(user, pollData));
    });
    return polls;
  }

  Future<dynamic> getPublicPolls() async {
    try {
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
      throw (error);
    }
  }

  Future<bool> attempToCreateAPoll(Object _pollData) async {
    try {
      var response = await NetworkHandler("/api/users/me/add-poll")
          .sendDataToServer(_pollData);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error) {
      throw error;
    }
  }
}
