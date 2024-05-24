import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import 'Progress Screen.dart';

class Progress extends StatelessWidget {
  const Progress({Key? key, required this.Level, required this.Subject});
  final String Level;
  final String Subject;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<SubjectCubit>(context);
    cubit.ProgressFetch(Level);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Progress,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<SubjectCubit, SubjectState>(
        builder: (context, state) {
          if (state is ProgressLoaded) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProgressSuccefull) {
            if (cubit.Progress.isEmpty) {
              return Column(
                children: [
                  Center(child: Text(S.of(context).Nosurveysavailable)),

                ],
              );



            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: cubit.Progress.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProgressScreen(Email:cubit.Progress[index]["email"], Subject: Subject,), // Navigate to ProgressScreen
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(cubit.Progress[index]["name"]),
                          subtitle: Text(cubit.Progress[index]["email"]),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          } else if (state is ProgressError) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
