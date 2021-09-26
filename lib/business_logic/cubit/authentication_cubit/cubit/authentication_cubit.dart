import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  static AuthenticationCubit get(BuildContext context) =>
      BlocProvider.of(context);

  void loginFun({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    emit(LoginLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginSucessfully());
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 4),
          content: Text("Please Check your Email or password Again!"),
          backgroundColor: Colors.red,
        ),
      );
      emit(LoginError());
    });
  }

  Future<void> signupFun({
    required String name,
    required String email,
    required String password,
    required int phone,
    required String address,
    required String neighborhood,
    required BuildContext context,
  }) async {
    try {
      emit(SignupLoading());
      var authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .set(
        {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'address': address,
          'neighborhood': neighborhood,
        },
      );

      emit(SignupSucessfully());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
      emit(SignupError());
    }
  }

  void signout() {
    emit(SignoutLoading());

    FirebaseAuth.instance.signOut().then((value) {
      emit(SignoutSucessfully());
    }).catchError((error) {
      print(error.toString());
      emit(SignoutError());
    });
  }
}
