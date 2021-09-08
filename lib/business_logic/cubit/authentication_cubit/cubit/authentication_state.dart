part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class LoginLoading extends AuthenticationState {}

class LoginSucessfully extends AuthenticationState {}

class LoginError extends AuthenticationState {}

class SignupLoading extends AuthenticationState {}

class SignupSucessfully extends AuthenticationState {}

class SignupError extends AuthenticationState {}
