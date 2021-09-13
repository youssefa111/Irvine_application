import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_task/business_logic/cubit/authentication_cubit/cubit/authentication_cubit.dart';
import 'package:first_task/helper/constants/constants.dart';
import 'package:first_task/presentation/profile_screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: Drawer(
          child: Container(
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
                        FirebaseAuth.instance.currentUser!.displayName
                            .toString(),
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                        child: Text(
                      FirebaseAuth.instance.currentUser!.email.toString(),
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Colors.white,
                          ),
                    )),
                  ],
                ),
              ),
            ),
            drawerSetting(
                title: 'Profile Settings',
                context: context,
                voidCallback: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfileScreen()))),
            drawerSetting(title: 'Feed Preferences', context: context),
            drawerSetting(title: 'My Activites', context: context),
            drawerSetting(title: 'Notifcations', context: context),
            drawerSetting(
                title: 'Invite friends & neighbors', context: context),
            drawerSetting(title: 'Help/Instructions', context: context),
            drawerSetting(title: 'Privacy Policy', context: context),
            drawerSetting(title: 'Agreement', context: context),
            BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                return drawerSetting(
                  title: 'Sign out',
                  context: context,
                  voidCallback: () =>
                      AuthenticationCubit.get(context).signout(),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}

Widget drawerSetting({
  required String title,
  required BuildContext context,
  VoidCallback? voidCallback,
}) =>
    InkWell(
      onTap: voidCallback,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 15.0),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
