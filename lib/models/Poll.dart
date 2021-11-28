import '../../models/ballots/Ballot.dart';
import 'User.dart';

enum VotingSystem { RCV, STAR, PLURALITY }

extension ParseToString on VotingSystem {
  String toShortString() {
    return this.toString().split('.').last;
  }
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
  String _results;
  String _createdTime;
  // List<String> _choices;

  // When editing choices, do not remove from array. Index needs to stay constant for votes.
  List<dynamic> _choices = [];
  // Indexes to ignore when calculating results
  List<int> _deletedChoices = [];

  List<Ballot> _votes = [];

  Poll(User creator, Map<String, dynamic> pollDataJson) {
    this._creator = creator;
    this._id = pollDataJson["poll_id"];
    this._title = pollDataJson["poll_title"];
    this._startTime = pollDataJson["start_time"];
    this._endTime = pollDataJson["end_time"];
    this._question = pollDataJson["prompt"];
    this._votingSystem = pollDataJson["vote_system"];
    this._createdTime = pollDataJson["created_at"];
    this._choices = pollDataJson["candidates"];
    this._imageUrl = pollDataJson["poll_image"];
    this._category = pollDataJson["poll_category"];
  }

  String getId() {
    return _id;
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

  void addChoice(String choice) {
    _choices.add(choice);
  }

  int getNumberOfChoices() {
    return _choices.length;
  }

  void deleteChoice(int choiceIndex) {
    _deletedChoices.add(choiceIndex);
  }

  List<Ballot> getVotes() {
    return _votes;
  }

  void addVote(Ballot ballot) {
    _votes.add(ballot);
  }

  String getWinner() {
    return _winner;
  }

  void setResults(String results) {
    this._results = results;
  }

  String getResults() {
    return _results;
  }
}
