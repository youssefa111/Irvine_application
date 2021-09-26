import 'package:first_task/business_logic/cubit/homescreen_cubit/home_screen_cubit.dart';
import 'package:first_task/helper/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ApplicationLayout extends StatelessWidget {
  const ApplicationLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context);
        return Scaffold(
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                gradient: linearGradient,
              ),
              child: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.report),
                    label: 'Report Issue',
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.newspaper),
                    label: 'Add News',
                  ),
                ],
                currentIndex: cubit.currentIndex,
                onTap: (int index) {
                  cubit.changeBottom(index);
                },
                selectedItemColor: Theme.of(context).primaryColor,
              ),
            ));
      },
    );
  }
}
