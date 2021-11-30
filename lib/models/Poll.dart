import '../../models/ballots/Ballot.dart';
import 'User.dart';

enum VotingSystem { RCV, STAR, PLURALITY }

extension ParseToString on VotingSystem {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class PollResults {
  String winner;
  String analysis;

  PollResults(this.winner, this.analysis);
  PollResults.fromJson(Map<String, dynamic> json)
      : analysis = json['analysis'],
        winner = json['elected'];
}

class Poll {
  String _id;
  User _creator;
  String _title;
  String _imageUrl;
  String _category;
  String _startTime;
  String _endTime;
  String _question;
  String _votingSystem;
  String _winner;
  String _status;
  String _createdTime;
  PollResults _results;
  int _numVotes;
  List<dynamic> _choices = [];
  List<Ballot> _votes = [];

  Poll(User creator, Map<String, dynamic> pollDataJson) {
    this._creator = creator;
    this._id = pollDataJson["poll_id"];
    this._category = pollDataJson["poll_category"];
    this._status = pollDataJson["poll_status"];
    this._title = pollDataJson["poll_title"];
    this._startTime = pollDataJson["start_time"];
    this._endTime = pollDataJson["end_time"];
    this._question = pollDataJson["prompt"];
    this._votingSystem = pollDataJson["vote_system"];
    this._createdTime = pollDataJson["created_at"];
    this._choices = pollDataJson["candidates"];
    this._imageUrl = pollDataJson["poll_image"];
    this._category = pollDataJson["poll_category"];
    this._results = PollResults.fromJson(pollDataJson['results']);
  }

  String getId() {
    return _id;
  }

  int getNumberOfVotes() {
    return _numVotes;
  }

  String getStatus() {
    return _status;
  }

  void setNumVoters(int newVotes) {
    this._numVotes = newVotes;
  }

  User getCreator() {
    return _creator;
  }

  String getImageUrl() {
    return _imageUrl;
  }

  String getCategory() {
    return _category;
  }

  String getTitle() {
    return _title;
  }

  List<dynamic> getChoices() {
    return _choices;
  }

  String getCreatedTime() {
    return _createdTime;
  }

  String getStartTime() {
    return _startTime;
  }

  String getEndTime() {
    return _endTime;
  }

  String getQuestion() {
    return _question;
  }

  String getVotingSystem() {
    return _votingSystem;
  }

  int getNumberOfChoices() {
    return _choices.length;
  }

  List<Ballot> getVotes() {
    return _votes;
  }

  String getWinner() {
    return _winner;
  }

  PollResults getResults() {
    return _results;
  }
}
