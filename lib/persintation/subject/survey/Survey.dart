import 'package:alexuadmin/persintation/subject/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../cubit/state.dart';

class Survey extends StatelessWidget {
  final String subject;

  const Survey({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<SubjectCubit>(context);
    cubit.fetchSurvey(subject);  // Call fetchSurvey with subject

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController helpNote = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Survey, // Localized text for Survey title
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<SubjectCubit, SubjectState>(
        builder: (context, state) {
          if (state is SurveyLoaded) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SurveySuccefull) {
            if (cubit.surveys.isEmpty) {
              return Center(child: Text(S.of(context).Nosurveysavailable));
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: cubit.surveys.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(S.of(context).AnonymousStudent),
                        subtitle: Text(cubit.surveys[index]["content"]),
                      ),
                    );
                  },
                ),
              );
            }
          } else if (state is SurveyError) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
