import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key, required this.Email, required this.Subject});
final String Email;
final String Subject;
  @override

  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<SubjectCubit>(context);
    cubit.ProgressFetchStudent(Email,Subject);
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
body:BlocBuilder<SubjectCubit, SubjectState>(
  builder: (context, state) {
    if (state is ProgressProfileLoaded) {
      return Center(child: CircularProgressIndicator());
    } else if (state is ProgressProfileSuccefull) {
      if (cubit.StudentProgress.isEmpty) {
        return Center(child: Text(S.of(context).ProgressandgradesforthisSubjectisempty));
      } else {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: cubit.StudentProgress.length,
            itemBuilder: (context, index) {
              return
                Card(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(cubit.StudentProgress[index]["Subject"]),
                    subtitle: Text(cubit.StudentProgress[index]["YearWorksGrad"]),
                  ),

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
