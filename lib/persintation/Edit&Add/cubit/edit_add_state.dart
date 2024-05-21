part of 'edit_add_cubit.dart';

@immutable
abstract class EditAddState {}

class EditAddInitial extends EditAddState {}

class ResetSuccess extends EditAddState {}

class ResetError extends EditAddState {
  final String? errorMessage;

  ResetError({this.errorMessage});
}

class CreateAccountSuccess extends EditAddState {}

class CreateAccountFailure extends EditAddState {
  final String? errorMessage;

  CreateAccountFailure(this.errorMessage);
}
