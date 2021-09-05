import 'package:bloc/bloc.dart';
import 'package:first_task/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'business_logic/cubit/bloc_observer.dart';
import 'business_logic/cubit/home_screen_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = MyBlocObserver();
  MyApp();
  runApp(MyApp());
}
// #1b3260
// '#a99e71'

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenCubit()..getHomeData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: HexColor('#1b3260'),
          appBarTheme: AppBarTheme(
            color: HexColor('#1b3260'),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
