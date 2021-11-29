import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/*This widget is for hiding description text that is too long to be shown on the homepage*/
class DescriptionTextWidget extends StatefulWidget {
  final String text;
  final String status;
  DescriptionTextWidget({@required this.text, @required this.status});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 135) {
      firstHalf = widget.text.substring(0, 135);
      secondHalf = widget.text.substring(135, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
      child: secondHalf.isEmpty
          ? new Text(firstHalf)
          : new Column(
              children: <Widget>[
                new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf)),
                /*
                new InkWell(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(
                        flag ? "show more" : "show less",
                        style: new TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),*/
              ],
            ),
    );
  }
}
