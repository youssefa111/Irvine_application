import 'package:first_task/helper/constants/constants.dart';
import 'package:first_task/presentation/home_screens/home_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var neighborhoodController = TextEditingController();
  var addressContrller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 25.0,
              right: 25.0,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Transform.scale(
                    child: BackButton(),
                    scale: 1.5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'REGISTER',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  myTextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validMessage: "please Enter your name",
                      labelText: "Name",
                      prefixIcon: Icons.person),
                  SizedBox(
                    height: 15.0,
                  ),
                  myTextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validMessage: "please Enter your email address",
                      labelText: "Email Address",
                      prefixIcon: Icons.email_outlined),
                  SizedBox(
                    height: 15.0,
                  ),
                  myTextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validMessage: "please is too short",
                      labelText: "Password",
                      prefixIcon: Icons.lock_outline,
                      obscureText: true),
                  SizedBox(
                    height: 15.0,
                  ),
                  myTextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validMessage: "please Enter your phone number",
                      labelText: "Phone",
                      prefixIcon: Icons.phone),
                  SizedBox(
                    height: 15.0,
                  ),
                  myTextFormField(
                      controller: addressContrller,
                      keyboardType: TextInputType.streetAddress,
                      validMessage: "please Enter your  address",
                      labelText: " Address",
                      prefixIcon: Icons.location_city),
                  SizedBox(
                    height: 15.0,
                  ),
                  myTextFormField(
                    controller: neighborhoodController,
                    keyboardType: TextInputType.text,
                    validMessage: "please Enter your neighborhod area",
                    labelText: "neighborhood",
                    prefixIcon: Icons.location_pin,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  myTextButton(
                    text: 'Register',
                    context: context,
                    function: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
