import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        title: Text(name!),
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
                height: 400.0,
                width: 300.0, // Set a specific width for the ListView
                child: Container(
                  color: Color(0xffF2F1F1),
                  child: ListView.builder(
                    itemCount: emailCountMap.length,
                    itemBuilder: (BuildContext context, int index) {
                      String email = emailCountMap.keys.elementAt(index);
                      int count = emailCountMap[email]!;

                      // Display only if count is greater than 1
                      if (count > 1) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20.0),
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
                                  "Student ID: $email",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  "TimeOfAbscence: $count",
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
                        return SizedBox.shrink(); // Return an empty SizedBox if count is 1
                      }
                    },
                  ),
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
