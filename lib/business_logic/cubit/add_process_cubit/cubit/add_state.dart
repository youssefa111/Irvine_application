part of 'add_cubit.dart';

@immutable
abstract class AddState {}

class AddInitial extends AddState {}

// ===========================Report ============================================

class AddReportLoading extends AddState {}

class AddReportSucessfully extends AddState {}

class AddReportError extends AddState {}

class ImageRemovedSucessfully extends AddState {}

class ImageAddedSucessfully extends AddState {}

class ReportAddedSucessfully extends AddState {}

// =========================== News ===============================================

class AddNewsLoading extends AddState {}

class AddNewsSucessfully extends AddState {}

class AddNewsError extends AddState {}
