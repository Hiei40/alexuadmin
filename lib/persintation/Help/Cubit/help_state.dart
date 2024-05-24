part of 'help_cubit.dart';

@immutable
abstract class HelpState {}

class HelpInitial extends HelpState {}

class HelpDataFetchedSuccessfully extends HelpState {}

class FeedbackDataFetchedSuccessfully extends HelpState {}

class SurveyDataFetchedSuccessfully extends HelpState {}

class HelpAddedSuccessfully extends HelpState {}

class HelpAddingFailed extends HelpState {
 final String error;
 HelpAddingFailed({required this.error});
}

class HelpDataFetchFailed extends HelpState {
 final String error;
 HelpDataFetchFailed({required this.error});
}

class FeedbackDataFetchFailed extends HelpState {
 final String error;
 FeedbackDataFetchFailed({required this.error});
}

class SurveyDataFetchFailed extends HelpState {
 final String error;
 SurveyDataFetchFailed({required this.error});
}
