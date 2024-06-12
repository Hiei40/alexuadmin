import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../../warning/warning.dart';
import 'Take Attendance.dart';
import 'Your Absence.dart';
import 'StudentAbsence.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key, required this.Name});
  final String Name;
  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Attendance, // Localized text for Feedback title
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .0321375921375921,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => WarningPage(id: '', name: '',)));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * .1021375921375921,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFF87CEEB),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        S.of(context).Warning,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: MediaQuery.of(context).size.height * .1021375921375921,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xFF87CEEB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StudentAbsence(
                                id: '',
                              )));
                    },
                    child: Container(
                      // Background color for "Logout" text
                      child: Text(
                        S.of(context).StudentAbsence,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
