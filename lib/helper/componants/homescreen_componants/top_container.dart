// ignore: must_be_immutable
import 'package:flutter/material.dart';

class TopContainer extends StatelessWidget {
  final double height;
  final double width;
  final String imagePath;
  final String title;
  final Widget widget;

  const TopContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.imagePath,
    required this.title,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => widget)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: width,
          height: height,
          color: Colors.grey[200],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                imagePath,
                width: width,
                height: height * .6,
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
