
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

class MyProfileSuccefull extends SubjectState {}

class EmptyState extends SubjectState {}

// Define HomeError class extending HomeState