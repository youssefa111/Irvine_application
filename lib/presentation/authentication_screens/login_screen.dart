import 'package:first_task/helper/constants/constants.dart';
import 'package:first_task/presentation/home_screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  myTextButton(
                    text: 'Login',
                    context: context,
                    function: () => Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'Forgot Password ?',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => RegisterScreen(),
                        ),
                      ),
                      child: Text(
                        'Don\'t have an Account or SignUp ?',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
