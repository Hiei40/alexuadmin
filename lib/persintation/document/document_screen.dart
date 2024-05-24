import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/l10n.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDDE7EE),
      body: Center(child: Container(
        width: 303,
        height: 215,
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${S.of(context).Pleasecontact}",maxLines: 5,
                overflow: TextOverflow.ellipsis,style: GoogleFonts.inter(
                fontSize:24,
                fontWeight: FontWeight.w600,
                color: Color(0xff000000),

            ),textAlign: TextAlign.center,
            ),
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
borderRadius: BorderRadius.circular(10)

                  ),
                  child: InkWell(
                   onTap: (){
                     Navigator.of(context).pop();
                   },
                    child: Text("Ok",                overflow: TextOverflow.ellipsis,style: GoogleFonts.inter(
                      fontSize:20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff000000),

                    ),textAlign: TextAlign.center,
                    ),
                  ),
                  width: 77,
                  height: 43,
                ),
              )
            ],)
          ],
        ),
      )),
    );
  }
}
