enum VotingSystem { rcv, star, plurality }

class Poll {
  int _id;
  String _title;
  int _startTime;
  int _endTime;
  String _question;
  VotingSystem _votingSystem;
  String _winner;
  String _results;

  // When editing choices, do not remove from array. Index needs to stay constant for votes.
  List<String> _choices = [];
  List<int> _deletedChoices = [];

  Poll(String title, int startTime, int endTime, String question,
      VotingSystem votingSystem) {
    this._title = title;
    this._startTime = startTime;
    this._endTime = endTime;
    this._question = question;
    this._votingSystem = votingSystem;
  }

  int getId() {
    return _id;
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

  String getWinner() {
    return _winner;
  }

  String getResults() {
    return _results;
  }
}
