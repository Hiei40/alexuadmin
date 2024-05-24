import 'package:meta/meta.dart';

// Define HomeState class
abstract class HomeState {}

// Define HomeInitial class extending HomeState
class HomeInitial extends HomeState {}

// Define HomeDataLoaded class extending HomeState
class HomeDataLoaded extends HomeState {}

class HomeDataSucceful extends HomeState {}

// Define HomeError class extending HomeState
class HomeError extends HomeState {
  final String error;

  HomeError({required this.error});
}
