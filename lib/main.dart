import 'package:alexuadmin/persintation/Edit&Add/cubit/edit_add_cubit.dart';
import 'package:alexuadmin/persintation/Help/Cubit/help_cubit.dart';
import 'package:alexuadmin/persintation/Home/Home.dart';
import 'package:alexuadmin/persintation/Home/cubit/home_cubit.dart';
import 'package:alexuadmin/persintation/Loclization/localization/localization_cubit.dart';
import 'package:alexuadmin/persintation/Loclization/localization/localization_state.dart';
import 'package:alexuadmin/persintation/auth/cubit/cubit.dart';
import 'package:alexuadmin/persintation/auth/cubit/state.dart';
import 'package:alexuadmin/persintation/profile/cubit/profile_cubit.dart';
import 'package:alexuadmin/persintation/subject/cubit/cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Model/Localization.dart';
import 'SplashScreen.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'persintation/auth/login_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context)=>SubjectCubit()),
        BlocProvider(create: (context)=>HelpCubit()),
        BlocProvider(create: (context)=>EditAddCubit()),

        BlocProvider(
          create: (context) =>
          LocalizationCubit()
            ..appLanguage(LanguageEventEnums.InitialLanguage),
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthMainState>(
        builder: (context, state) {
          // Lock the orientation to portrait when the screen is loaded
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return BlocBuilder<LocalizationCubit,LocalizationState>(
            builder: (context, langState) {
              return MaterialApp(
                locale: langState is ChangeLanguage ? Locale(langState.languageCode!) : null,
                supportedLocales: S.delegate.supportedLocales,
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (deviceLocale, supportedLocals) {
                  for (var local in supportedLocals) {
                    if (deviceLocale != null) {
                      if (deviceLocale.languageCode == local.languageCode) {
                        return deviceLocale;
                      }
                    }
                  }
                  return supportedLocals.first;
                },
                title: 'Flutter Demo',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                debugShowCheckedModeBanner: false,

                home: SplashScreen(),
                routes: {
                  "Home":(context)=>Admin(),


                },
                // home: SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
