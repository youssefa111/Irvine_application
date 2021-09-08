import 'package:first_task/helper/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../business_logic/cubit/homescreen_cubit/home_screen_cubit.dart';

// ignore: must_be_immutable
class NewReportContainer extends StatelessWidget {
  final String reporterName;
  final String reportContent;
  final List<dynamic> reportImage;
  final String reportName;
  final String reportLocation;
  final String reporterLetter;
  ContainerCategory containerCategory = ContainerCategory.newsContiner;

  NewReportContainer(
      {Key? key,
      required this.reporterName,
      required this.reportContent,
      required this.reportImage,
      required this.reportName,
      required this.reportLocation,
      required this.reporterLetter,
      containerCategory})
      : super(key: key);

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
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
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
                        context: context,
                        builder: (context) => OptionsDialog());
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
                FittedBox(
                    child: Text(
                  reportName,
                  style: TextStyle(
                    fontSize: 10,
                  ),
                )),
                Spacer(),
                Icon(Icons.location_on),
                FittedBox(
                    child: Text(
                  reportLocation,
                  style: TextStyle(
                    fontSize: 10,
                  ),
                )),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            reportImage.isNotEmpty
                ? Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: reportImage.map((e) {
                      return Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width /
                            reportImage.length,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          image: DecorationImage(
                              image: FileImage(e), fit: BoxFit.fill),
                        ),
                      );
                    }).toList())
                : SizedBox(
                    height: 10,
                  ),
            SizedBox(
              height: 10,
            ),
            Text(reportContent),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 1,
            ),
            InteractBar(),
          ],
        ),
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
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        return FittedBox(
          child: Row(
            children: <Widget>[
              InteractButton(
                  func: () => HomeScreenCubit.get(context).interactAgree(),
                  icon: HomeScreenCubit.get(context).agreedIcon,
                  iconName: 'Agree'),
              InteractButton(
                  func: () => HomeScreenCubit.get(context).interactDisagree(),
                  icon: HomeScreenCubit.get(context).disagreedIcon,
                  iconName: 'Disagree'),
              InteractButton(
                  icon: FontAwesomeIcons.comment, iconName: 'Comment'),
              InteractButton(icon: FontAwesomeIcons.share, iconName: 'Share'),
            ],
          ),
        );
      },
    );
  }
}

class InteractButton extends StatelessWidget {
  final IconData icon;
  final String iconName;
  final VoidCallback? func;

  const InteractButton({
    Key? key,
    required this.icon,
    this.func,
    required this.iconName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (InkWell(
      onTap: () => func!(),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FaIcon(icon),
            SizedBox(
              width: 5,
            ),
            Text(iconName)
          ],
        ),
      ),
    ));
  }
}
