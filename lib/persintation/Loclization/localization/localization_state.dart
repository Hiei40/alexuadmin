import 'package:meta/meta.dart';

@immutable
abstract class LocalizationState {}

class LocalizationInitial extends LocalizationState {}

class ChangeLanguage extends LocalizationState {
  final String? languageCode;

  ChangeLanguage({this.languageCode});
}
