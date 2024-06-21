import 'package:flutter/material.dart';
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
          S.of(context).StudentAbsence,
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
            // Group absences by email
            Map<String, List<Absence>> groupedAbsences = {};

            cubit.absence2.forEach((absence) {
              if (groupedAbsences.containsKey(absence.email)) {
                groupedAbsences[absence.email]!.add(absence);
              } else {
                groupedAbsences[absence.email] = [absence];
              }
            });

            return ListView.builder(
              itemCount: groupedAbsences.length,
              itemBuilder: (BuildContext context, int index) {
                String email = groupedAbsences.keys.elementAt(index);
                List<Absence> absences = groupedAbsences[email]!;

                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Color(0xff87CEEB),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Student Email: $email",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: absences.map((absence) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Time Of Absence: ${absence.dateOfAbsence}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
