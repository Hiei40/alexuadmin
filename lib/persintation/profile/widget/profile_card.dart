import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {super.key,
      required this.title,
      required this.body,
      required this.Controller, this.validator, this.onFieldSubmitted, this.onSaved});
  final String? title;
  final String? body;
  final TextEditingController Controller;
  final  String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1591375921375921,
        width: MediaQuery.of(context).size.width * 0.8846666666666667,
        decoration: BoxDecoration(
          color: Color(0xFF87CEEB),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: Text(
                title!,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 15,
              child: Divider(
                height: 1,
                color: Colors.white,
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8446666666666667,
                child: TextFormField(
                  controller: Controller,
                  onFieldSubmitted: onFieldSubmitted,
                  onSaved: onSaved,
                  validator: validator,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: body,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
