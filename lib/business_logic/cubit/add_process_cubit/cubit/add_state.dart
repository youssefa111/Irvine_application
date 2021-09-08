part of 'add_cubit.dart';

@immutable
abstract class AddState {}

class AddInitial extends AddState {}

class AddReportLoading extends AddState {}

class AddReportSucessfully extends AddState {}

class AddReportError extends AddState {}

class ImageRemovedSucessfully extends AddState {}

class AddNewsLoading extends AddState {}

class AddNewsSucessfully extends AddState {}

class AddNewsError extends AddState {}
