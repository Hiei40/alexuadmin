import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/l10n.dart';
import 'ForgetPassword.dart';
import 'cubit/edit_add_cubit.dart';
import 'cubit/edit_add_state.dart';
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).ForgetPassword),
      ),
      body: BlocConsumer<EditAddCubit, EditAddState>(
        listener: (BuildContext context, state ) {
          if (state is ResetSuccess) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Container(
                    alignment: Alignment.center,
                    height: 300,
                    width: 500,
                    child: Text(
                      S.of(context).Wesentaresetlinktoyouremail,
                      style: GoogleFonts.inter(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    S.of(context).PleaseinsertanEmailthatyouwanttoresethisPassword,
                    style: GoogleFonts.inter(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                      hintText: S.of(context).Email,
                      hintStyle: GoogleFonts.inter(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      } else if (!value.contains("@")) {
                        return "Email is not valid";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<EditAddCubit>(context).forgetPassword(emailController.text);
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
          );
        },
      ),
    );
  }
}
