import 'package:alexuadmin/persintation/Edit&Add/AddEdit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/l10n.dart';
import '../profile/widget/profile_card.dart';
import 'cubit/edit_add_cubit.dart';
import 'cubit/edit_add_state.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ID = TextEditingController();
  final TextEditingController Cgpa = TextEditingController();


  final TextEditingController departmentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var Cubit=BlocProvider.of<EditAddCubit>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(
        S.of(context).Student,
      )),body:  BlocConsumer<EditAddCubit, EditAddState>(
      listener: (context, state) {
        if (state is CreateAccountSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Account created successfully')),
          );
        } else if (state is CreateAccountFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create account: ${state.errorMessage}')),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    BlocBuilder<EditAddCubit, EditAddState>(
                      builder: (context, state) {
                        return CircleAvatar(
                          radius: 70,
                          child: Cubit.SelectImage != null
                              ? CircleAvatar(
                            backgroundImage: FileImage(Cubit.SelectImage!),
                            radius: 70, // Adjust the radius as needed
                          )
                              : CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/alexu-a9210.appspot.com/o/Human1.png?alt=media&token=2d11398d-3864-419b-a260-3bf885663daa"),
                            radius: 25, // Adjust the radius as needed
                          ),
                          // profileImageUrl != null
                          //     ? FileImage(File(profileImageUrl))
                          //     : const AssetImage("Image/Human1.png") ,
                        );
                      },
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: IconButton(
                        onPressed: () {
                          BlocProvider.of<EditAddCubit>(context).addProfileImage();
                        },
                        icon: Icon(Icons.camera_alt),
                      ),
                    ),
                  ],
                ),
                ProfileCard(
                  title:"ID",
                  body: "ID",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Id is required";
                    } else {
                      return null;
                    }
                  },
                  Controller: ID,
                ),
                ProfileCard(
                  title: S.of(context).Name,
                  body: S.of(context).Name,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Empty";
                    }
                    final RegExp regex = RegExp(
                        r'[0-9\u0600-\u06FF!@#$%^&*()_+=?><":}{\][|/-]+');
                    if (regex.hasMatch(value)) {
                      return "Invalid characters found";
                    }
                    return null;
                  },
                  Controller: nameController,
                ),
                ProfileCard(
                  title: S.of(context).Email,
                  body: S.of(context).Email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    } else if (!value.contains("@")) {
                      return "Email is not valid";
                    } else {
                      return null;
                    }
                  },
                  Controller: emailController,
                ),
                ProfileCard(
                  title: S.of(context).Password,
                  body: S.of(context).Password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "${S.of(context).Passwordisrequired}";
                    } else {
                      return null;
                    }
                  },
                  Controller: passwordController,
                ),
                ProfileCard(
                  title: S.of(context).Department,
                  body: S.of(context).Department,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).Departmentisempty;
                    } else {
                      return null;
                    }
                  },
                  Controller: departmentController,
                ),
                ProfileCard(
                  title:"CGPA",
                  body: "CGPA",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    } else {
                      return null;
                    }
                  },
                  Controller: Cgpa,
                ),
                SizedBox(height: 50),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<EditAddCubit>(context).createStudentAccount(
                        emailController.text,
                        passwordController.text,
                        nameController.text,
                        '',
                        departmentController.text,
                      ).then((userCredential) {
                      }).catchError((error) {
                        print("Error creating account: $error");
                        // Handle error if needed
                      });
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
          ),
        );
      },
    ),
    );
  }
}
