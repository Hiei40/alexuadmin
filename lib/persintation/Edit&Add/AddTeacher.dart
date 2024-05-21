
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/l10n.dart';
import '../profile/widget/profile_card.dart';
import 'cubit/edit_add_cubit.dart';
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class AddTeacher extends StatelessWidget {
  const AddTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController EmailController = TextEditingController();
    TextEditingController Password = TextEditingController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(

      appBar: AppBar(
        title: Text(S.of(context).Teacher),
      ),
      body: BlocConsumer<EditAddCubit, EditAddState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Form(
       key: _formKey,
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius:70,
                  child: Image.asset("Image/Human1.png",height: 50,width: 50,),
                ),
                Positioned(child: IconButton(onPressed: (){
                  BlocProvider.of<EditAddCubit>(context).addProfileImage();
                }, icon: Icon(Icons.camera_alt)),
                  right: 0,
                  bottom: 0,

                )
              ],
            ),
            ProfileCard(
              title: S.of(context).Name,
              body: S.of(context).Name,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Empty";
                }
                final RegExp regex =
                    RegExp(r'[0-9\u0600-\u06FF!@#$%^&*()_+=?><":}{\][|/-]+');
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
                if (value!.isEmpty) {
                  return "Email is required";
                } else if (!value.contains("@")) {
                  return "Email is not valid";
                } else {
                  return null;
                }
              },
              Controller: EmailController,
            ),
            ProfileCard(
              title: S.of(context).Password,
              body: S.of(context).Password,
              validator: (value) {
                if (value!.isEmpty) {
                  return "${S.of(context).Passwordisrequired}";
                } else {
                  return null;
                }
              },
              Controller: Password,
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
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
