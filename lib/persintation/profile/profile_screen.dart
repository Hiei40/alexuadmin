import 'package:alexuadmin/persintation/profile/widget/profile_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/profile_cubit.dart';
import 'cubit/profile_state.dart';
import 'widget/profile_card.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit = ProfileCubit.get(context);
    cubit.MyProfile();
    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
        return state is EmptyState || cubit.data.isEmpty ?
        Center(child: CircularProgressIndicator(),)
            : Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 200.0),
                child: InkWell(
                    onTap: () async{
                      await cubit.addProfileImage();
                    },
                    child: ProfileImage(image:cubit.data["image"],)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 230.0,top: 10),
                child: Text(cubit.data["name"]),
              ),
              ProfileCard(title: 'ID',
                body:FirebaseAuth.instance.currentUser!.uid ,),
              ProfileCard(title: 'Email',
                body:FirebaseAuth.instance.currentUser!.email,),
              ProfileCard(title: 'Department',
                body:cubit.data["department"] ,),
              ProfileCard(title: 'Level',
                body:cubit.data["level"] ,),
              ProfileCard(title: 'CGPA',
                body:cubit.data["CGPA"] ,),
            ],
          ),
        );
      }),
    );
  }
}
