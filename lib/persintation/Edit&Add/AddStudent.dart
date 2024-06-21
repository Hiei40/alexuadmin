import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/l10n.dart';
import '../profile/widget/DropDownMenuYear.dart';
import '../profile/widget/profile_card.dart';
import 'cubit/edit_add_cubit.dart';
import 'cubit/edit_add_state.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var cubit = BlocProvider.of<EditAddCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Student,
        ),
      ),
      body: BlocConsumer<EditAddCubit, EditAddState>(
        listener: (context, state) {
          if (state is CreateAccountSuccess) {
            _formKey.currentState!.reset();
            nameController.clear();
            emailController.clear();
            passwordController.clear();
            idController.clear();
            departmentController.clear();
            cubit.clearProfileImage(); // Clear profile image in cubi
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Account created successfully')),
            );
          } else if (state is CreateAccountFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('Failed to create account: ${state.errorMessage}')),
            );
          }
        },
        builder: (context, state) {
          var Cubit = BlocProvider.of<EditAddCubit>(context);
          String? profileImageUrl;
          String? selectedLevel;

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
                      BlocBuilder<EditAddCubit, EditAddState>(
                        builder: (context, state) {
                          return CircleAvatar(
                            radius: 70,
                            child: cubit.SelectImage != null
                                ? CircleAvatar(
                                    backgroundImage:
                                        FileImage(cubit.SelectImage!),
                                    radius: 70,
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://firebasestorage.googleapis.com/v0/b/alexu-a9210.appspot.com/o/Human1.png?alt=media&token=2d11398d-3864-419b-a260-3bf885663daa"),
                                    radius: 25,
                                  ),
                          );
                        },
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: IconButton(
                          onPressed: () {
                            BlocProvider.of<EditAddCubit>(context)
                                .addProfileImage();
                          },
                          icon: Icon(Icons.camera_alt),
                        ),
                      ),
                    ],
                  ),
                  ProfileCard(
                    title: "ID",
                    body: "ID",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "ID is required";
                      } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return "ID must be a number";
                      }
                      return null;
                    },
                    Controller: idController,
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
                  ProfileDropDownMenu(
                    title: 'Select Level',
                    items: [
                      'First Level – Semester1',
                      'First Level – Semester2',
                      'Second Level – Semester 3',
                      "Second Level – Semester 4",
                      "Third Level – Semester 5",
                      "Third Level – Semester 6",
                      "Fourth Level – Semester 7",
                      "Fourth Level – Semester 8"
                    ],
                    selectedValue: selectedLevel ??
                        'First Level – Semester1', // Ensure default value is set
                    onChanged: (String? newValue) {
                      // Update selectedLevel when dropdown value changes
                      selectedLevel = newValue;
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an option';
                      }
                      return null;
                    },
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
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (selectedLevel != null) {
                          BlocProvider.of<EditAddCubit>(context)
                              .createStudentAccount(
                            emailController.text,
                            passwordController.text,
                            nameController.text,
                            profileImageUrl ?? '',
                            departmentController.text,
                            int.parse(idController.text),
                            selectedLevel!, // Use the non-nullable value of selectedLevel
                          )
                              .then((userCredential) {
                            print({
                              'name': nameController.text,
                              'user_type': "Student",
                              "id": int.parse(idController.text),
                              'Level':
                                  selectedLevel, // Use selectedLevel directly
                              'image': profileImageUrl,
                              'email': emailController.text,
                              'department': departmentController.text,
                            });
                          }).catchError((error) {
                            print("Error creating account: $error");
                            // Handle error if needed
                          });
                        } else {
                          // Handle the case where selectedLevel is null
                          // This could be logging an error or displaying a message to the user
                          print('Error: selectedLevel is null');
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff87CEEB),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height:
                          (75 / height) * MediaQuery.of(context).size.height,
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
