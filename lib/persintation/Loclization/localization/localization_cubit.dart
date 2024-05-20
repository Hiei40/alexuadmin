import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Const/SharedPref.dart';
import '../../../Model/Localization.dart';
import 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());
  appLanguage(LanguageEventEnums eventType) {
    final sharedPreferences = SharedPreferences.getInstance();
    sharedPreferences.then((prefs) {
      switch (eventType) {
        case LanguageEventEnums.InitialLanguage:
          final language = prefs.getString('language');
          if (language != null) {
            if (language == 'ar') {
              emit(ChangeLanguage(languageCode: 'ar'));
            } else {
              emit(ChangeLanguage(languageCode: 'en'));
            }
          }
          break;
        case LanguageEventEnums.ArabicLanguage:
          prefs.setString('language', 'ar');
          emit(ChangeLanguage(languageCode: 'ar'));
          break;
        case LanguageEventEnums.EnglishLanguage:
          prefs.setString('language', 'en');
          emit(ChangeLanguage(languageCode: 'en'));
          break;
        default:
      }
    });
  }

}
