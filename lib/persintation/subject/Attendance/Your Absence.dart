import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class AllAbsence extends StatelessWidget {
  const AllAbsence({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SubjectCubit cubit=SubjectCubit.get(context);
    cubit.getAbsences();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).YourAbsence, // Localized text for Feedback title
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<SubjectCubit,SubjectState>(
        builder: (context,state) {
          return state is AbsencesLoadState || cubit.allIdAbsences.isEmpty ?  Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
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
                          // Background color for "Logout" text
                          child: Text(
                            S.of(context).YourAbsence,
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
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height, // Example fixed height
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          "${index + 1}) ${cubit.allIdAbsences[index]}",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                              fontSize:20
                          ),
                        );
                      },
                      itemCount: cubit.allIdAbsences.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
