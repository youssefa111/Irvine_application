import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_task/presentation/authentication_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'business_logic/cubit/bloc_observer.dart';
import 'business_logic/cubit/homescreen_cubit/home_screen_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = MyBlocObserver();

  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );
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
        // locale: DevicePreview.locale(context), // Add the locale here
        // builder: DevicePreview.appBuilder, // Add the builder here
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: HexColor('#18A2D9'),
        ),
        home: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              HexColor("#0D8AE3"),
              HexColor("#4BB9BC"),
              HexColor("#3DC681"),
            ], begin: Alignment.topCenter, end: Alignment.bottomRight),
          ),
          child: AnimatedSplashScreen(
            duration: 2000,
            splash: FittedBox(
              child: Text(
                'OneGov',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            nextScreen: LoginScreen(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
