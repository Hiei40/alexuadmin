import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../generated/l10n.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../cubit/state.dart';

class AddGrades extends StatelessWidget {
  AddGrades({super.key, required this.Email, required this.Subject});

  final String Email;
  final String Subject;
  final TextEditingController FinalGrade = TextEditingController();
  final TextEditingController MedGrade = TextEditingController();
  final TextEditingController WorkYear = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).AddGrade),
      ),
      body: BlocConsumer<SubjectCubit, SubjectState>(
        listener: (context, state) {
          if (state is GradeAddedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).GradeAddedSuccess)),
            );
            Navigator.of(context).pop();
          } else if (state is GradeAddedError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: WorkYear,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: S.of(context).YearWorkGrad,
                      labelStyle: GoogleFonts.inter(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).YearWorkGradRequired;
                      } else {
                        final n = num.tryParse(value);
                        if (n == null || n < 0 || n >= 21) {
                          return S.of(context).InvalidYearWorkGrad;
                        }
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: MedGrade,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: S.of(context).MedTermGrad,
                      labelStyle: GoogleFonts.inter(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).MedTermGradRequired;
                      } else {
                        final n = num.tryParse(value);
                        if (n == null || n <= 0 || n >= 21) {
                          return S.of(context).InvalidMedTermGrad;
                        }
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: FinalGrade,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: S.of(context).FinalGrad,
                      labelStyle: GoogleFonts.inter(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).FinalGradRequired;
                      } else {
                        final n = num.tryParse(value);
                        if (n == null || n <= 0 || n >= 61) {
                          return S.of(context).InvalidFinalGrad;
                        }
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final int finalGrade = int.parse(FinalGrade.text);
                      final int medGrade = int.parse(MedGrade.text);
                      final int workYear = int.parse(WorkYear.text);

                      BlocProvider.of<SubjectCubit>(context).addGrades(Subject, Email, finalGrade, medGrade, workYear);
                    }
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
            ),
          );
        },
      ),
    );
  }
}
