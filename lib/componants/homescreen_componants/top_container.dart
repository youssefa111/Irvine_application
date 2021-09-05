// ignore: must_be_immutable
import 'package:first_task/presentation/report_category_screen.dart';
import 'package:flutter/material.dart';

class TopContainer extends StatelessWidget {
  final double height;
  final double width;
  final String imagePath;
  final String title;

  const TopContainer({
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
      child: Card(
        child: Container(
          width: width,
          height: height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                imagePath,
                width: width,
                height: height * .7,
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
      ),
    );
  }
}
