import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import 'AddGrades.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key, required this.email, required this.subject, required this.Name})
      : super(key: key);
  final String email;
  final String subject;
  final String Name;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<SubjectCubit>(context);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    cubit.ProgressFetchStudent(email, subject);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).ProgressofStudent,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<SubjectCubit, SubjectState>(
        builder: (context, state) {
          if (state is ProgressProfileLoaded) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProgressProfileSuccefull) {
            if (cubit.studentProgress.isEmpty) {
              return Column(
                children: [
                  Center(
                      child: Text(S.of(context).ProgressandgradesforthisSubjectisempty)),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddGrades(Email: email, Subject: subject,),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF2191CE),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: (50 / height) * MediaQuery.of(context).size.height,
                      width: (200 / width) * MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text(
                        S.of(context).AddGrade,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w300,
                          fontSize: MediaQuery.of(context).size.width < 500
                              ? MediaQuery.of(context).size.width * 0.0472
                              : MediaQuery.of(context).size.width < 800
                              ? MediaQuery.of(context).size.width * 0.05
                              : MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: cubit.studentProgress.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 400,
                          child: TextFormField(
                            initialValue: email,
                            readOnly: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email),
                              labelText: S.of(context).Email,
                            ),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w300,
                              fontSize: MediaQuery.of(context).size.width < 500
                                  ? MediaQuery.of(context).size.width * 0.0472
                                  : MediaQuery.of(context).size.width < 800
                                  ? MediaQuery.of(context).size.width * 0.05
                                  : MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 400,
                          child: TextFormField(
                            initialValue: Name,
                            readOnly: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person),
                              labelText: S.of(context).Name,
                            ),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w300,
                              fontSize: MediaQuery.of(context).size.width < 500
                                  ? MediaQuery.of(context).size.width * 0.0472
                                  : MediaQuery.of(context).size.width < 800
                                  ? MediaQuery.of(context).size.width * 0.05
                                  : MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 400,
                          child: TextFormField(
                            initialValue: cubit.studentProgress[index]["Subject"],
                            readOnly: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: S.of(context).Subject,
                            ),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w300,
                              fontSize: MediaQuery.of(context).size.width < 500
                                  ? MediaQuery.of(context).size.width * 0.0472
                                  : MediaQuery.of(context).size.width < 800
                                  ? MediaQuery.of(context).size.width * 0.05
                                  : MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 400,
                          child: TextFormField(
                            initialValue: '${cubit.studentProgress[index]["YearWork"]}',
                            readOnly: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: S.of(context).YearWorkGrad,
                            ),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w300,
                              fontSize: MediaQuery.of(context).size.width < 500
                                  ? MediaQuery.of(context).size.width * 0.0472
                                  : MediaQuery.of(context).size.width < 800
                                  ? MediaQuery.of(context).size.width * 0.05
                                  : MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 400,
                          child: TextFormField(
                            initialValue: '${cubit.studentProgress[index]["MedtermGrad"]}',
                            readOnly: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: S.of(context).MedTermGrad,
                            ),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w300,
                              fontSize: MediaQuery.of(context).size.width < 500
                                  ? MediaQuery.of(context).size.width * 0.0472
                                  : MediaQuery.of(context).size.width < 800
                                  ? MediaQuery.of(context).size.width * 0.05
                                  : MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 400,
                          child: TextFormField(
                            initialValue: '${cubit.studentProgress[index]["Final"]}',
                            readOnly: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: S.of(context).FinalGrad,
                            ),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w300,
                              fontSize: MediaQuery.of(context).size.width < 500
                                  ? MediaQuery.of(context).size.width * 0.0472
                                  : MediaQuery.of(context).size.width < 800
                                  ? MediaQuery.of(context).size.width * 0.05
                                  : MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  },
                ),
              );
            }
          } else if (state is ProgressProfileError) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
