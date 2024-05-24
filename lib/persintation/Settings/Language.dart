import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Model/Localization.dart';
import '../../generated/l10n.dart';
import '../Loclization/localization/localization_cubit.dart';
import '../Loclization/localization/localization_state.dart';

class Language extends StatefulWidget {
  const Language({Key? key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Language,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height:    MediaQuery.of(context).size.height * .0321375921375921,
            ),
            BlocBuilder<LocalizationCubit, LocalizationState>(
  builder: (context, state) {
    return InkWell(
              onTap: (){
                BlocProvider.of<LocalizationCubit>(context)
                    .appLanguage(LanguageEventEnums.EnglishLanguage);
              },
              child: Container(
                height: MediaQuery.of(context).size.height * .1021375921375921,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFF87CEEB),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        S.of(context).English,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
  },
),
            SizedBox(
              height: 50,
            ),
            BlocBuilder<LocalizationCubit, LocalizationState>(
  builder: (context, state) {
    return Container(
              height: MediaQuery.of(context).size.height * .1021375921375921,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xFF87CEEB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(),
                  InkWell(
onTap: (){
  BlocProvider.of<LocalizationCubit>(context)
      .appLanguage(LanguageEventEnums.ArabicLanguage);
},
                    child: Container(
                      // Background color for "Logout" text
                      child: Text(
                        S.of(context).Arabic,

                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
  },
),
          ],
        ),
      ),
    );
  }
}
