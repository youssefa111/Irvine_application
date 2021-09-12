part of 'home_screen_cubit.dart';

@immutable
abstract class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

//==================== HomeScreen States =========================================

class HomeScreenLoading extends HomeScreenState {}

class HomeScreenSucess extends HomeScreenState {}

class HomeScreenError extends HomeScreenState {}

//==================== Filter States =========================================

class FilteredSucessfully extends HomeScreenState {}

//==================== Interaction States =========================================

class InteractedSucessfully extends HomeScreenState {}

class InteractedLoading extends HomeScreenState {}

class InteractedError extends HomeScreenState {}

//==================== Search States =========================================

class SearchSucessfully extends HomeScreenState {}

//==================== options States =========================================

class OptionsSucessfully extends HomeScreenState {}
