enum VotingSystem { rcv, star, plurality }

class Poll {
  int _id;
  String _title;
  int _startTime;
  int _endTime;
  String _question;
  VotingSystem _votingSystem;

  // When editing choices, do not remove from array. Index needs to stay constant for votes.
  List<String> _choices = [];
  List<int> _deletedChoices = [];

  Poll(String title, int startTime, int endTime, String question,
      VotingSystem votingSystem) {
    _title = title;
    _startTime = startTime;
    _endTime = endTime;
    _question = question;
    _votingSystem = votingSystem;
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

  void deleteChoice(int choiceIndex) {
    _deletedChoices.add(choiceIndex);
  }
}
