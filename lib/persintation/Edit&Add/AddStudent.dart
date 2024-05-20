import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(S.of(context).ForgetPassword),
      ),


    );
  }
}
