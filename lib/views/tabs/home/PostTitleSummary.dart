import 'package:better_vote/helper/descriptionTextWidget.dart';
import 'package:better_vote/models/Poll.dart';
import 'package:flutter/material.dart';

class PostTitleAndSummary extends StatelessWidget {
  final Poll poll;
  const PostTitleAndSummary(this.poll, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final TextStyle titleTheme = Theme.of(context).textTheme.title;
    //final TextStyle summaryTheme = Theme.of(context).textTheme.body1;
    final String title = poll.getTitle();
    final String summary = poll.getQuestion();
    final String image = poll.getImageUrl();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          SizedBox(height: 10),
          image == 'no image' || image == null
              ? Container(child: new DescriptionTextWidget(text: summary))
              : Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 18.0 / 13.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), 
                        child: Image.network(
                          image,
                          fit: BoxFit.fill,
                        )
                      ),
                    ),
                    SizedBox(height: 10),
                  ]
                ),
          // Text(summary, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
