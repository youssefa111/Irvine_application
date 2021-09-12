import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_task/model/report_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../business_logic/cubit/homescreen_cubit/home_screen_cubit.dart';

// ignore: must_be_immutable
class NewReportContainer extends StatelessWidget {
  final ReportModel model;
  final String reportID;

  const NewReportContainer(
      {Key? key, required this.model, required this.reportID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenCubit(),
      child: Card(
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
                        model.reporterLetter,
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
                    model.reporterName,
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
                    model.reportName,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                  Spacer(),
                  Text(
                    model.date,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              model.reportImage != null
                  ? Wrap(
                      runSpacing: 10,
                      spacing: 2,
                      children: model.reportImage!.map((e) {
                        return Container(
                          height: 70,
                          width: e == model.reportImage!.last &&
                                  model.reportImage!.length == 3
                              ? MediaQuery.of(context).size.width
                              : MediaQuery.of(context).size.width / 2.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: NetworkImage(e), fit: BoxFit.fill),
                          ),
                        );
                      }).toList())
                  : SizedBox(
                      height: 10,
                    ),
              SizedBox(
                height: 10,
              ),
              Text(model.reportContent),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .doc(reportID)
                          .snapshots(),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            '( ${model.reportLikes} Agrees , ${model.reportDislikes} Disagrees , ${model.reportComments} Comments )',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          );
                        }
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Text(
                          '( ${data['reportLikes']} Agrees , ${data['reportDislikes']} Disagrees , ${data['reportComments']} Comments )',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        );
                      }),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 1,
              ),
              InteractBar(
                key: key,
              ),
            ],
          ),
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
  const InteractBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            InteractButton(
                func: () => HomeScreenCubit.get(context).interactAgree(
                      key
                          .toString()
                          .replaceAll(RegExp('\[<\'>\]'), '')
                          .replaceAll(']', '')
                          .replaceAll('[', ''),
                    ),
                icon: HomeScreenCubit.get(context).agreedIcon,
                iconName: 'Agree'),
            InteractButton(
                func: () => HomeScreenCubit.get(context).interactDisagree(
                      key
                          .toString()
                          .replaceAll(RegExp('\[<\'>\]'), '')
                          .replaceAll(']', '')
                          .replaceAll('[', ''),
                    ),
                icon: HomeScreenCubit.get(context).disagreedIcon,
                iconName: 'Disagree'),
            InteractButton(icon: FontAwesomeIcons.comment, iconName: 'Comment'),
          ],
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
            FaIcon(
              icon,
              size: 18,
            ),
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
