import 'package:meta/meta.dart';

// Define HomeState class
abstract class ProfileState {}

// Define HomeInitial class extending HomeState
class ProfileInitial extends ProfileState {}

// Define HomeDataLoaded class extending HomeState
class ProfileLoaded extends ProfileState {}

class ProfileSucceful extends ProfileState {}

class EmptyState extends ProfileState {}

class AddImageMyProfileState extends ProfileState {}
// Define HomeError class extending HomeState
