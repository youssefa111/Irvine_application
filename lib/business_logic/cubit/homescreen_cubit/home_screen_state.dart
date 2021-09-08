part of 'home_screen_cubit.dart';

@immutable
abstract class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoading extends HomeScreenState {}

class HomeScreenSucess extends HomeScreenState {}

class HomeScreenError extends HomeScreenState {}

class MediaAddedSucessfully extends HomeScreenState {}

class ReportAddedSucessfully extends HomeScreenState {}

class FilteredSucessfully extends HomeScreenState {}

class ImageRemovedSucessfully extends HomeScreenState {}

class InteractedSucessfully extends HomeScreenState {}

class SearchSucessfully extends HomeScreenState {}
