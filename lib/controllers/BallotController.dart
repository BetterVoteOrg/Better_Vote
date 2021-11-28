import 'package:better_vote/network/NetworkHandler.dart';

class BallotController {
  Future<bool> attempToSubmitABallot(String pollId, List<int> ballotSelections) async {
    try {
      var response = await NetworkHandler("/api/users/me/submit-vote")
          .sendDataToServer({'poll_id': pollId, 'selections': ballotSelections});
      return response.statusCode == 200;
    } catch (error) {
      throw error;
    }
  }
}
