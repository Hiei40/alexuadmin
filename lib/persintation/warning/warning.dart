import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../generated/l10n.dart';
import '../../utils/theme/color_manger/color_mange.dart';
import '../subject/cubit/cubit.dart';
import '../subject/cubit/state.dart';

class WarningPage extends StatelessWidget {
  const WarningPage({super.key, required this.id, required this.name});
  final String? name;
  final String? id;

  @override
  Widget build(BuildContext context) {
    SubjectCubit cubit = SubjectCubit.get(context);
    cubit.AbsenceTeacherFetch(name!);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Warning),
      ),
      body: BlocProvider(
        create: (context) => SubjectCubit()..AbsenceTeacherFetch(name!),
        child: BlocBuilder<SubjectCubit, SubjectState>(
          builder: (context, state) {
            if (state is AbsencesLoadState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AbsencesSuccfulState) {
              final cubit = context.read<SubjectCubit>();

              // Map to count occurrences of each email
              Map<String, int> emailCountMap = {};

              // Populate emailCountMap
              cubit.absence2.forEach((absence) {
                String email = absence.email;
                emailCountMap.update(email, (value) => value + 1, ifAbsent: () => 1);
              });

              return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: emailCountMap.length,
                  itemBuilder: (BuildContext context, int index) {
                    String email = emailCountMap.keys.elementAt(index);
                    int count = emailCountMap[email]!;

                    if (count > 1) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: count > 3 ? Colors.red : Color(0xff87CEEB),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Student ID: $email",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                count > 3 ? "Refuse" : "Warning",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                "Time Of Absence: $count",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              );
            } else if (state is AbsencesErrorState) {
              return Center(
                child: Text('Error loading absences: ${state.error}'),
              );
            } else {
              return Center(
                child: Container(),
              );
            }
          },
        ),
      ),
    );
  }
}
