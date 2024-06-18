import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../generated/l10n.dart';
import '../Model/AbsenceModel.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class StudentAbsence extends StatelessWidget {
  const StudentAbsence({Key? key, required this.id, required this.Name}) : super(key: key);
  final String? id;
  final String Name;

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      // Handle null id case gracefully
      return Scaffold(
        body: Center(
          child: Text('ID is null'),
        ),
      );
    }

    SubjectCubit cubit = SubjectCubit.get(context);
    cubit.AbsenceTeacherFetch(Name);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).YourAbsence,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<SubjectCubit, SubjectState>(
        builder: (context, state) {
          if (state is AbsencesLoadState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          Absence absence = cubit.absence2[index];

                          // Format the date
                          String formattedDate = DateFormat('yyyy-MM-dd','en').format(absence.dateOfAbsence.toDate());

                          return Text(
                            "${index + 1}) ${absence.email}, $formattedDate",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          );
                        },
                        itemCount: cubit.absence2.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
