import 'package:first_task/presentation/report_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class TopContainer extends StatelessWidget {
  final double height;
  final double width;
  final String imagePath;
  final String title;

  TopContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ReportCategoryScreen())),
      child: Container(
        width: width,
        height: height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              imagePath,
              width: width,
              height: height / 2,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 5,
            ),
            FittedBox(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    return Container(
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
                  color: Colors.blue,
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
              Text(newsDate),
              if (newsThanks != 0)
                SizedBox(
                  width: 5,
                ),
              if (newsThanks != 0) Text('$newsThanks Thanks'),
              if (newsThanks != 0)
                SizedBox(
                  width: 5,
                ),
              if (newsReplies != 0) Text('$newsReplies Replies'),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReportContainer extends StatelessWidget {
  final String reporterName;
  final String reportContent;
  final String reportImage;
  final String reportName;
  final String reportLocation;
  final String reporterLetter;

  const ReportContainer({
    Key? key,
    required this.reporterName,
    required this.reportContent,
    required this.reportImage,
    required this.reportName,
    required this.reportLocation,
    required this.reporterLetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    reporterLetter,
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
              Spacer(),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context, builder: (context) => OptionsDialog());
                },
                icon: Icon(Icons.more_horiz),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(reportName),
              Spacer(),
              Icon(Icons.location_on),
              Text(reportLocation),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              image: DecorationImage(
                  image: AssetImage(reportImage), fit: BoxFit.fill),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(reportContent),
          SizedBox(
            height: 5,
          ),
          Divider(),
          InteractBar(),
        ],
      ),
    );
  }
}

class OptionsDialog extends StatefulWidget {
  const OptionsDialog({Key? key}) : super(key: key);

  @override
  _OptionsDialogState createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {
  int? group = 0;
  bool checkBox = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        height: MediaQuery.of(context).size.height * .7,
        width: MediaQuery.of(context).size.width * .8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: InteractButton(
                    icon: FontAwesomeIcons.share, iconName: 'Share'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: InteractButton(
                    icon: FontAwesomeIcons.eyeSlash, iconName: 'Hide post'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: InteractButton(
                    icon: FontAwesomeIcons.flag, iconName: 'Report post'),
              ),
              Row(
                children: <Widget>[
                  Radio<int>(
                    value: 1,
                    groupValue: group,
                    onChanged: (value) {
                      setState(() {
                        group = value;
                      });
                    },
                  ),
                  Text('Inappropraite'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio<int>(
                    value: 2,
                    groupValue: group,
                    onChanged: (value) {
                      setState(() {
                        group = value;
                      });
                    },
                  ),
                  Text('Inappropraite'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio<int>(
                    value: 3,
                    groupValue: group,
                    onChanged: (value) {
                      setState(() {
                        group = value;
                      });
                    },
                  ),
                  Text('Privacy concernt'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio<int>(
                    value: 4,
                    groupValue: group,
                    onChanged: (value) {
                      setState(() {
                        group = value;
                      });
                    },
                  ),
                  Text('Commercial solicitiation'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio<int>(
                    value: 5,
                    groupValue: group,
                    onChanged: (value) {
                      setState(() {
                        group = value;
                      });
                    },
                  ),
                  Text('False report'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {},
                    child: Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InteractBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InteractButton(icon: FontAwesomeIcons.thumbsUp, iconName: 'Agree'),
        InteractButton(icon: FontAwesomeIcons.thumbsDown, iconName: 'Disagree'),
        InteractButton(icon: FontAwesomeIcons.comment, iconName: 'Comment'),
        InteractButton(icon: FontAwesomeIcons.share, iconName: 'Share'),
      ],
    );
  }
}

class InteractButton extends StatelessWidget {
  final IconData icon;
  final String iconName;

  const InteractButton({
    Key? key,
    required this.icon,
    required this.iconName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FaIcon(icon),
            SizedBox(
              width: 10,
            ),
            Text(iconName)
          ],
        ),
      ),
    );
  }
}
