import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_task/helper/constants/constants.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context, snapshot) {
          Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
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
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              'assets/grifatti.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            data['name'],
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Text(
                            data['email'],
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InfoRow(infoData: 'Name', infoType: data['name']),
                InfoRow(infoData: 'Email', infoType: data['email']),
                InfoRow(infoData: 'Password', infoType: data['password']),
                InfoRow(infoData: 'Phone Number', infoType: data['phone']),
                InfoRow(infoData: 'Address', infoType: data['address']),
                InfoRow(
                    infoData: 'Neighborhood', infoType: data['neighborhood']),
              ],
            ),
          );
        });
  }
}

class InfoRow extends StatelessWidget {
  final String infoData;
  final String infoType;
  const InfoRow({Key? key, required this.infoData, required this.infoType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          infoType,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Spacer(),
        Text(
          infoData,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }
}
