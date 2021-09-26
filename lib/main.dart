import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_task/business_logic/cubit/authentication_cubit/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'business_logic/cubit/bloc_observer.dart';
import 'business_logic/cubit/homescreen_cubit/home_screen_cubit.dart';
import 'presentation/application_layout.dart';
import 'presentation/authentication_screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}
// #1b3260
// '#a99e71'

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeScreenCubit(),
        ),
        BlocProvider(
          create: (context) => AuthenticationCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          appBarTheme: AppBarTheme(
            foregroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.white,
            ),
            color: Colors.white,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
          primaryColor: HexColor("#4BB9BC"),
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
            nextScreen: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return FutureBuilder(
                        future: Future.wait([
                          HomeScreenCubit.get(context).getHomeData(),
                          HomeScreenCubit.get(context).userDataLoad(),
                          HomeScreenCubit.get(context).gethidePostsList(),
                        ]),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return BlocBuilder<HomeScreenCubit,
                                HomeScreenState>(
                              builder: (context, state) {
                                return ApplicationLayout();
                              },
                            );
                          }

                          return Scaffold(
                            body: Center(child: CircularProgressIndicator()),
                          );
                        });
                  }
                  return LoginScreen();
                }),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
