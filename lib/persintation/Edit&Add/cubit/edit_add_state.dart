import 'package:meta/meta.dart';

@immutable
abstract class EditAddState {}

class EditAddInitial extends EditAddState {}

class ResetSuccess extends EditAddState {}

class ResetError extends EditAddState {
  final String errorMessage;

  ResetError({required this.errorMessage});
}

class CreateAccountSuccess extends EditAddState {}

class CreateAccountFailure extends EditAddState {
  final String? errorMessage;

  CreateAccountFailure(this.errorMessage);
}
