import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/theme/controller/controller.dart';
import '../document/document_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import '../../generated/l10n.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    AuthCubit cubit = AuthCubit.get(context);
    return Scaffold(
resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff87CEEB),
      body: BlocBuilder<AuthCubit, AuthMainState>(
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: (250 / 800) * height,
                        width: (200 / 800) * height,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("Image/gradp.png"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: Controllers.email,
                          decoration: InputDecoration(
                            hintText: "${S.of(context).Email}",
                            hintStyle: GoogleFonts.inter(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
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
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: Controllers.password,
                          obscureText: !cubit.see,
                          decoration: InputDecoration(
                            hintText: "${S.of(context).Password}",
                            hintStyle: GoogleFonts.inter(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                cubit.seeCubit();
                              },
                              child: cubit.see
                                  ? Icon(Icons.remove_red_eye_outlined)
                                  : Icon(Icons.remove_red_eye),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "${S.of(context).Passwordisrequired}";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              child: Text(
                                S.of(context).Forgotpassword,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DocumentScreen()));
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: (200/411)* MediaQuery.of(context).size.width,
                      ),
                      InkWell(
                        onTap: () {
                          cubit.signInCubit(context,Controllers.email.text, Controllers.password.text);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF2191CE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: (75 / height) * MediaQuery.of(context).size.height,
                          width: (300 / width) * MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Text(
                            S.of(context).Signin,
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
