import 'package:alexuadmin/persintation/subject/Model/SubjectModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';
import '../../utils/theme/color_manger/color_mange.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'subject_info.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key});
//
  @override
  Widget build(BuildContext context) {
    var cubit =     BlocProvider.of<SubjectCubit>(context);
cubit.fetchData();
    // cubit.MyProfile();
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Subjects),
      ),
      body: BlocBuilder<SubjectCubit, SubjectState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 10.0, // Spacing between columns
                mainAxisSpacing: 10.0, // Spacing between rows
              ),
              itemCount: cubit.course.length,
              itemBuilder: (c, i) {
                Course course= cubit.course[i];
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) {
                      return SubjectInfo(
                        name: course.name,
                        Level: course.level,
                      );
                    }));
                  },
                  child: Container(
                    color: ColorManger.main_color,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 40),
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: ColorManger.dark_container,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "${i + 1}",
                            style: TextStyle(
                              color: ColorManger.main_color,
                            ),
                            textAlign: TextAlign.center, // Use TextAlign.center instead of Alignment.center
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          course.name,
                          textAlign: TextAlign.center, // Use TextAlign.center instead of Alignment.center
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      }),
    );
  }
}
// cubit.listSubject[i]
