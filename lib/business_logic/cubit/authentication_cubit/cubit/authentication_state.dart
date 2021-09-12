part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

//==================== Login States =========================================

class LoginLoading extends AuthenticationState {}

class LoginSucessfully extends AuthenticationState {}

class LoginError extends AuthenticationState {}

//==================== signup States =========================================

class SignupLoading extends AuthenticationState {}

class SignupSucessfully extends AuthenticationState {}

class SignupError extends AuthenticationState {}

//==================== signout States =========================================

class SignoutSucessfully extends AuthenticationState {}

class SignoutLoading extends AuthenticationState {}

class SignoutError extends AuthenticationState {}
