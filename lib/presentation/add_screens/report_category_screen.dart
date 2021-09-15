import 'package:flutter/material.dart';
import '../../helper/constants/constants.dart';
import 'report_screen.dart';

class ReportCategoryScreen extends StatelessWidget {
  const ReportCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List categoryList = [
      ReportCategory(icon: 'assets/2.png', iconName: 'Other'),
      ReportCategory(icon: 'assets/6.png', iconName: 'Traffic Signal Issues'),
      ReportCategory(
          icon: 'assets/10.png', iconName: 'COVID Qeustions / Concerns'),
      ReportCategory(icon: 'assets/5.png', iconName: 'Facility Maintenance'),
      ReportCategory(icon: 'assets/4.png', iconName: 'Street Light Repair'),
      ReportCategory(
          icon: 'assets/7.png', iconName: 'Graffitti At City Facility'),
      ReportCategory(icon: 'assets/3.png', iconName: 'Inefficient Water Use'),
      ReportCategory(icon: 'assets/1.png', iconName: 'App Feedback'),
      ReportCategory(icon: 'assets/8.png', iconName: 'Repost A Code Violation'),
      ReportCategory(icon: 'assets/9.png', iconName: 'Damaged Street Sign'),
      ReportCategory(icon: 'assets/9.png', iconName: 'Test Name'),
    ];
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: linearGradient,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Choose Category',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => categoryList[index],
                  separatorBuilder: (Context, index) => SizedBox(
                        height: 20,
                      ),
                  itemCount: categoryList.length),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'search',
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
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
  final String icon;
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
            Image.asset(
              icon,
              height: 50,
              width: 50,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              iconName,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
