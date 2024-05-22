import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../generated/l10n.dart';
import '../profile/widget/profile_card.dart';
import 'cubit/edit_add_cubit.dart';
import 'cubit/edit_add_state.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController departmentController = TextEditingController();

class AddTeacher extends StatelessWidget {
  const AddTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Teacher),
      ),
      body: BlocConsumer<EditAddCubit, EditAddState>(
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
          String? profileImageUrl;
          if (state is ProfileImageSelected) {
            profileImageUrl = state.imageUrl;
          }

          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: profileImageUrl != null
                            ? FileImage(File(profileImageUrl))
                            : AssetImage("Image/Human1.png") as ImageProvider,
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
                    title: S.of(context).Name,
                    body: S.of(context).Name,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Name is required";
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
                        return "Email is empty";
                      } else if (!value.contains("@")) {
                        return "Email not valid";
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
                        return S.of(context).Passwordisrequired;
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
                  SizedBox(height: 50),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await BlocProvider.of<EditAddCubit>(context).createAccount(
                            emailController.text,
                            passwordController.text,
                            nameController.text,
                            profileImageUrl ?? '',
                            departmentController.text,
                          );
                        } catch (error) {
                          print("Error creating account: $error");
                          // Handle error if needed
                        }
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
