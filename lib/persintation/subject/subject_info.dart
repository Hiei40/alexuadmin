import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/theme/color_manger/color_mange.dart';
import '../../utils/theme/list/list.dart';
import 'Attendance/Attendance.dart';
import 'FeedBack/Feedback.dart';
import 'progress/Progress.dart';
import 'survey/Survey.dart';

class SubjectInfo extends StatelessWidget {
  const SubjectInfo({super.key,required this.name,required this.Level});
  final String ? name;
 final String ?Level;

  @override
  Widget build(BuildContext context) {
    List Subject=[Attendance(),Feedbacks(),Progress(),Survey()];
    return Scaffold(
      appBar:  AppBar(
        title: Text(name!),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20,top: 10),
        child: Container(
          width:double.infinity,
          child: ListView.builder(
              itemCount: MainList.nameListSubjectInfo(context).length,
              itemBuilder: (c,index){
                print(index+1);
            return Padding(
              padding: const EdgeInsets.only(bottom: 30.0,top: 15),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Subject[index],
                    ),
                  );

                },
                child: Container(
                  height: MediaQuery.of(context).size.height/8,
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: (index+1)%2 ==0 ? ColorManger.main_color:ColorManger.secondary_color,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(MainList.imageListSubjectInfo[index]),
                            fit: BoxFit.scaleDown
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text(MainList.nameListSubjectInfo(context)[index], style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w500, // Corrected from FontWeight:FontWeight.w500
                        color: Colors.white,
                      )),

                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
