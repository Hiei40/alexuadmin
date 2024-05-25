
// Define HomeState class
abstract class SubjectState {}

// Define HomeInitial class extending HomeState
class SubjectInitial extends SubjectState {}

// Define HomeDataLoaded class extending HomeState
class SubjectLoaded extends SubjectState {}

class SubjectSuccefull extends SubjectState {}
class SubjectError extends SubjectState {

  final String error;

  SubjectError({required this.error});


}
class SurveyLoaded extends SubjectState {}
class SurveySuccefull extends SubjectState {}
class SurveyError extends SubjectState {

  final String error;

  SurveyError({required this.error});


}
class FeedBackLoaded extends SubjectState {}
class FeedBackSuccefull extends SubjectState {}
class FeedBackError extends SubjectState {

  final String error;

  FeedBackError({required this.error});


}
class ProgressLoaded extends SubjectState {}
class ProgressSuccefull extends SubjectState {}
class ProgressError extends SubjectState {

  final String error;

  ProgressError({required this.error});


}
class ProgressProfileLoaded extends SubjectState {}
class ProgressProfileSuccefull extends SubjectState {}
class ProgressProfileError extends SubjectState {

  final String error;

  ProgressProfileError({required this.error});


}



class MyProfileSuccefull extends SubjectState {}

class EmptyState extends SubjectState {}

class GradeAddedSuccess extends SubjectState {}

class GradeAddedError extends SubjectState {
  final String error;
  GradeAddedError({required this.error});
}
// Define HomeError class extending HomeState