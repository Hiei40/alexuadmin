import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
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
    cubit.getAbsence("Calculus");
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
          return state is AbsenceLoadState || cubit.allIdAbsence.isEmpty
              ? Center(
            child: CircularProgressIndicator(),
          )
              : SingleChildScrollView(
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
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          "${index + 1}) ${cubit.allIdAbsence}",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        );
                      },
                      itemCount: cubit.allIdAbsence.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
