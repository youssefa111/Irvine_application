import 'package:first_task/model/user_model.dart';
import 'package:flutter/material.dart';

import '../../helper/constants/constants.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel model;
  const ProfileScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .32,
            decoration: BoxDecoration(
              gradient: linearGradient,
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  BackButton(
                    color: Colors.white,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/employee.png',
                      height: 70,
                      width: 70,
                      color: Colors.white,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      model.name,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      model.email,
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InfoRow(infoData: 'Name', infoType: model.name),
          InfoRow(infoData: 'Email', infoType: model.email),
          InfoRow(infoData: 'Password', infoType: model.password),
          InfoRow(infoData: 'Phone Number', infoType: model.phone.toString()),
          InfoRow(infoData: 'Address', infoType: model.address),
          InfoRow(infoData: 'Neighborhood', infoType: model.neighborhood),
        ],
      ),
    ));
  }
}

class InfoRow extends StatelessWidget {
  final String infoData;
  final String infoType;
  const InfoRow({Key? key, required this.infoData, required this.infoType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 5.0,
          left: 8.0,
          right: 8.0,
          bottom: MediaQuery.of(context).size.height * .05),
      child: Row(
        children: <Widget>[
          Text(
            infoData,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
          ),
          Spacer(),
          Text(
            infoType,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.grey[700],
                  fontSize: 12,
                ),
          ),
        ],
      ),
    );
  }
}
