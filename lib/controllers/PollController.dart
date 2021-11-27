import 'dart:convert';
import 'package:better_vote/models/Poll.dart';
import 'package:better_vote/models/User.dart';
import 'package:better_vote/network/NetworkHandler.dart';
import 'package:better_vote/network/S3BucketHandler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class PollController {
  PollController();
  S3BucketHandler bucketHandler = S3BucketHandler();
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
        print(data['poll_image']);
        polls.add(Poll(pollCreator, data));
      });
      return polls;
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> attempToCreateAPoll(Map pollData, {XFile pollImage}) async {
    try {
      if (pollImage != null) {
        S3URLResponse s3response = await bucketHandler
            .generatePresignedUrl(path.extension(pollImage.path));
        if (s3response.success) {
          bool isUploaded = await bucketHandler.uploadImageFileToS3(
              s3response.uploadUrl, pollImage);
          if (isUploaded) {
            pollData['poll_image'] = s3response.downloadUrl;
          }
        }
      }

      var response = await NetworkHandler("/api/users/me/add-poll")
          .sendDataToServer(pollData);
      return response.statusCode == 200;
    } catch (error) {
      throw error;
    }
  }
}
