import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/l10n.dart';
import 'AddStudent.dart';

class AddEdit extends StatelessWidget {
  const AddEdit({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> photos = [
      "https://firebasestorage.googleapis.com/v0/b/alexu-a9210.appspot.com/o/Student.png?alt=media&token=f5d8c314-0976-4743-8dbd-af7bf4823643",
      "https://firebasestorage.googleapis.com/v0/b/alexu-a9210.appspot.com/o/Teacher.png?alt=media&token=9e0384a1-8101-47d5-93b9-215e6a0fbee7",
      "https://firebasestorage.googleapis.com/v0/b/alexu-a9210.appspot.com/o/ForgetPassword.png?alt=media&token=9a2f8789-919f-419a-b7fd-b52e4b460ff4"
    ];

    List<String> text2 = [
      S.of(context).Student,
      S.of(context).Teacher,
      S.of(context).ForgetPassword
    ];
List Screens=[
  AddStudent(),

];
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Add),
      ),
      body: ListView.separated(
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Add your onTap logic here
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFF87CEEB),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(photos[index],width: 24,height: 24,),
                      SizedBox(width: 8), // Add space between icon and text
                      Text(
                        text2[index],
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 30);
        },
      ),
    );
  }
}
