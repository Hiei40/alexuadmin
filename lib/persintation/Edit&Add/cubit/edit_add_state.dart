part of 'edit_add_cubit.dart';

@immutable
sealed class EditAddState {}

final class EditAddInitial extends EditAddState {}
class ResetSucces extends EditAddState{}