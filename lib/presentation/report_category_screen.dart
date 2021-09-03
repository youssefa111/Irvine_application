import 'package:first_task/presentation/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReportCategoryScreen extends StatelessWidget {
  const ReportCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Report Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: [
                  ReportCategory(
                    icon: FontAwesomeIcons.thumbsUp,
                    iconName: 'Other',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ReportCategory(
                    icon: FontAwesomeIcons.thumbsUp,
                    iconName: 'Traffic Signal Issues',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ReportCategory(
                    icon: FontAwesomeIcons.thumbsUp,
                    iconName: 'COVID Questions / Concerns',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ReportCategory(
                    icon: FontAwesomeIcons.thumbsUp,
                    iconName: 'Facility Maintenance',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ReportCategory(
                    icon: FontAwesomeIcons.thumbsUp,
                    iconName: 'Street Light Repair',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ReportCategory(
                    icon: FontAwesomeIcons.thumbsUp,
                    iconName: 'Graffiti At City Facility',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ReportCategory(
                    icon: FontAwesomeIcons.thumbsUp,
                    iconName: 'Inefficient wATE uSER',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ReportCategory(
                    icon: FontAwesomeIcons.thumbsUp,
                    iconName: 'App Feedback',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ReportCategory(
                    icon: FontAwesomeIcons.thumbsUp,
                    iconName: 'Repost A Code Violation',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ReportCategory(
                    icon: FontAwesomeIcons.thumbsUp,
                    iconName: 'Damaged Street Sign',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ReportCategory(
                    icon: FontAwesomeIcons.thumbsUp,
                    iconName: 'Test Name',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ReportCategory(
                    icon: FontAwesomeIcons.thumbsUp,
                    iconName: 'Other',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ReportCategory(
                    icon: FontAwesomeIcons.thumbsUp,
                    iconName: 'Other',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ReportCategory(
                    icon: FontAwesomeIcons.thumbsUp,
                    iconName: 'Other',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(),
                ),
                SizedBox(
                  width: 25,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {},
                  child: FittedBox(
                    child: Text(
                      'Find',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ReportCategory extends StatelessWidget {
  final IconData icon;
  final String iconName;

  const ReportCategory({
    Key? key,
    required this.icon,
    required this.iconName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              ReportScreen(iconData: icon, reportCategoryName: iconName),
        ),
      ),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FaIcon(
              icon,
              size: 30,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              iconName,
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
