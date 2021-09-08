import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                    width: 5,
                  ),
                if (isAgency)
                  Text(
                    'AGENCY',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                Spacer(),
                Text(
                  newsDate,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              newsTitle,
              style: Theme.of(context).textTheme.button!.copyWith(
                    fontWeight: FontWeight.bold,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '( $newsThanks Thanks , $newsReplies Replies )',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 5,
                ),
                NewsReactButton(
                    icon: FontAwesomeIcons.heart, text: 'Thank', fun: () {}),
                SizedBox(
                  width: 15,
                ),
                NewsReactButton(
                    icon: FontAwesomeIcons.reply, text: 'Reply', fun: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NewsReactButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback fun;
  const NewsReactButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.fun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => fun,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FaIcon(
            icon,
            size: 18,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            text,
          ),
        ],
      ),
    );
  }
}
