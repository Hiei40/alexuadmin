import 'package:alexuadmin/persintation/Home/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/l10n.dart';
import 'cubit/home_cubit.dart';

class AddAnouncment extends StatelessWidget {
  const AddAnouncment({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController AddAnouncment = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).Announcement, // Localized text for Feedback title
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body:  Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(

            children: [
              Container(
                child: Text(
                  S.of(context).AddyourAccounment,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 10), // Add spacing between text and text field
              Container(
                padding: EdgeInsets.all(10), // Add padding to TextField
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color for note effect
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                width: width * 0.8, // Adjust width as per your requirement
                height: 200, // Adjust height as per your requirement
                child: TextField(
                  controller: AddAnouncment,
                  maxLines: 10, // Allowing multiple lines of text
                  decoration: InputDecoration(
                    hintText: S.of(context).PleaseWrite, // Placeholder text
                    border: InputBorder.none, // Remove border
                  ),
                ),
              ),
              SizedBox(height: 30),

              InkWell(
                onTap: () {
                  if (AddAnouncment.text.isNotEmpty) {
                    BlocProvider.of<HomeCubit>(context).Addannouncement(AddAnouncment.text);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Admin()),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff87CEEB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: (75 / height) * MediaQuery.of(context).size.height,
                  width: (300 / width) * MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context).Send,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )

    );
  }
}
