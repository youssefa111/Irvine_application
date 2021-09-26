part of 'home_screen_cubit.dart';

@immutable
abstract class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

//==================== ChangeBottomNav States =========================================

class ChangeBottomNavState extends HomeScreenState {}

//==================== HomeScreen States =========================================

class HomeScreenLoading extends HomeScreenState {}

class HomeScreenSucess extends HomeScreenState {}

class HomeScreenError extends HomeScreenState {}

//==================== Filter States =========================================

class FilterChange extends HomeScreenState {}

class FilteredSucessfully extends HomeScreenState {}

//==================== SEARCH States =========================================

class SearchHomeSucessfully extends HomeScreenState {}

//==================== Interaction States =========================================

class InteractedSucessfully extends HomeScreenState {}

class InteractedLoading extends HomeScreenState {}

class InteractedError extends HomeScreenState {}

//==================== Comment States =========================================

class CommentSucessfully extends HomeScreenState {}

class CommentLoading extends HomeScreenState {}

class CommentError extends HomeScreenState {}

class ShowComment extends HomeScreenState {}

//==================== Reply States =========================================

class ReplySucessfully extends HomeScreenState {}

class ReplyLoading extends HomeScreenState {}

class ReplyError extends HomeScreenState {}

class ShowReply extends HomeScreenState {}

//==================== Search States =========================================

class SearchSucessfully extends HomeScreenState {}

//==================== Hide Post States =========================================

class HidePostSucessfully extends HomeScreenState {}

class HidePostError extends HomeScreenState {}

class HidePostsListLoadedSucessfully extends HomeScreenState {}

class HidePostsListLoading extends HomeScreenState {}

class HidePostsListLoadedError extends HomeScreenState {}

//==================== Undo Post States =========================================
class UndoPostLoading extends HomeScreenState {}

class UndoPostSucessfully extends HomeScreenState {}

class UndoPostError extends HomeScreenState {}
