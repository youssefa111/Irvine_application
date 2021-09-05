import 'package:flutter/material.dart';

class NewsContainer extends StatelessWidget {
  final String reporterName;
  final String newsTitle;
  final String newsContent;
  final String newsDate;
  final String iconLetter;
  final int newsThanks;
  final int newsReplies;
  final bool isAgency;

  NewsContainer({
    Key? key,
    required this.reporterName,
    required this.newsTitle,
    required this.newsContent,
    required this.newsDate,
    required this.iconLetter,
    required this.isAgency,
    required this.newsThanks,
    required this.newsReplies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      iconLetter,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  reporterName,
                ),
                if (isAgency)
                  SizedBox(
                    width: 8,
                  ),
                if (isAgency)
                  Text(
                    'AGENCY',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              newsTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            ),
            Text(newsContent),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  newsDate,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                if (newsThanks != 0)
                  SizedBox(
                    width: 5,
                  ),
                if (newsThanks != 0)
                  Text(
                    '$newsThanks Thanks',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                if (newsThanks != 0)
                  SizedBox(
                    width: 5,
                  ),
                if (newsReplies != 0)
                  Text(
                    '$newsReplies Replies',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
