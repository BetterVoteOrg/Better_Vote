import '../../models/ballots/Ballot.dart';
import 'User.dart';

enum VotingSystem { RCV, STAR, PLURALITY }

class Poll {
  int _id;
  User _creator;
  String _title;
  String _startTime;
  String _endTime;
  String _question;
  String _votingSystem;
  String _winner;
  String _results;

  // When editing choices, do not remove from array. Index needs to stay constant for votes.
  List<String> _choices = [];
  // Indexes to ignore when calculating results
  List<int> _deletedChoices = [];

  List<Ballot> _votes = [];

  Poll(User creator, Map<String, dynamic> data) {
    this._creator = creator;
    this._title = data["poll_title"];
    this._startTime = data["start_time"];
    this._endTime = data["end_time"];
    this._question = data["prompt"];
    this._votingSystem = data["vote_system"];
  }

  int getId() {
    return _id;
  }

  User getCreator() {
    return _creator;
  }

  String getTitle() {
    return _title;
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

  List<String> getChoices() {
    return _choices;
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
