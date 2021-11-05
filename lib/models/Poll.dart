import '../controllers/UserController.dart';
import '../../models/ballots/Ballot.dart';

enum VotingSystem { RCV, STAR, PLURALITY }

class Poll {
  int _id;
  User _creator;
  String _title;
  int _startTime;
  int _endTime;
  String _question;
  VotingSystem _votingSystem;
  String _winner;
  String _results;

  // When editing choices, do not remove from array. Index needs to stay constant for votes.
  List<String> _choices = [];
  // Indexes to ignore when calculating results
  List<int> _deletedChoices = [];

  List<Ballot> _votes = [];

  Poll(User creator, String title, int startTime, int endTime, String question,
      VotingSystem votingSystem) {
    this._creator = creator;
    this._title = title;
    this._startTime = startTime;
    this._endTime = endTime;
    this._question = question;
    this._votingSystem = votingSystem;
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

  int getStartTime() {
    return _startTime;
  }

  int getEndTime() {
    return _endTime;
  }

  String getQuestion() {
    return _question;
  }

  VotingSystem getVotingSystem() {
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

  void setWinner(String winner) {
    this._winner = winner;
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
