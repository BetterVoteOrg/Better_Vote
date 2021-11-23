import 'package:flutter/material.dart';
import 'package:better_vote/models/Poll.dart';

class VoteInAPollForm extends StatelessWidget {
  final Poll poll;
  const VoteInAPollForm(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        //width: MediaQuery.of(context).size.width,
        child: Column(
      children: <Widget>[_getVotingForm()],
    ));
  }

  Widget _getVotingForm() {
    String rcv = "RCV";
    String star = "STAR";
    String plurality = "Plurality";

    final String votingSystem = poll.getVotingSystem();

    //debugPrint("here we are");

    if (votingSystem == rcv) {
      return _RCVForm(poll);
    } else if (votingSystem == star) {
      return _STARForm(poll);
    } else if (votingSystem == plurality) {
      return _PluralityForm(poll);
    }
  }
}

class _RCVForm extends StatefulWidget {
  final Poll poll;
  _RCVForm(this.poll, {Key key}) : super(key: key);
  @override
  State<_RCVForm> createState() => _RCVFormState(this.poll);
}

class _RCVFormState extends State<_RCVForm> {
  final Poll poll;
  _RCVFormState(this.poll);
  List<String> choices;

  @override
  void initState() {
    super.initState();

    //List<String> list = ['choice a', 'choice b', 'choice c', 'choice d'];
    //choices.addAll(list);
  }

  @override
  Widget build(BuildContext context) {
    print(poll.getChoices());
    List<dynamic> choices = poll.getChoices();
    //int numberOfChoices = poll.getNumberOfChoices();
    // List<String> choices = ['choice a', 'choice b', 'choice c', 'choice d'];
    //int numberOfChoices = 4;
    //debugPrint(choices.toString());
    //debugPrint(numberOfChoices.toString());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "\t\tRank\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tChoices",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            itemCount: choices.length,
            itemBuilder: (BuildContext context, int index) {
              //debugPrint("this right here2");
              return Container(
                height: 50,
                child: Row(children: [
                  Text("\t\t\t\t\t" +
                      (index + 1).toString() +
                      "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"),
                  _choicesDropDown(choices)
                ]),
              );
            }),
        Align(
            alignment: Alignment.center,
            child: TextButton(
                onPressed: () {},
                child: Text(
                  "Submit Vote",
                  style: TextStyle(fontSize: 20, color: Colors.green),
                )))
      ],
    );
  }

  /*
  Widget _choice(String choiceName){
    return Container(child: Text(choiceName));
  }
  */

  Widget _choicesDropDown(List<dynamic> choices) {
    //String _selectedLocation;
    //List<String> _choices = ['A', 'B', 'C', 'D'];
    String _selectedValue;

    return DropdownButton<String>(
      hint: Text('Please choose an option'), // Not necessary for Option 1

      value: _selectedValue,

      items: choices
          .map((dynamic choice) => DropdownMenuItem<String>(
                value: choice,
                child: Text(choice),
              ))
          .toList(),

      onChanged: (String changedValue) {
        setState(() {
          _selectedValue = changedValue;
          print("Selected Value: " + _selectedValue);
        });
      },
      //value: newValue,
    );
    /*
    return DropdownButton(
      value: null,
      isDense: true,
      onChanged: (String newValue) {
        // somehow set here selected 'value' above whith 
       // newValue
       // via setState or reactive.
      },
      items: ['yellow', 'brown', 'silver'].map((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
    */
  }
}

class _STARForm extends StatelessWidget {
  final Poll poll;
  const _STARForm(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [Text("Testing star")],
      ),
    );
  }
}

class _PluralityForm extends StatelessWidget {
  final Poll poll;
  const _PluralityForm(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text("Testing plurality")],
    );
  }
}
