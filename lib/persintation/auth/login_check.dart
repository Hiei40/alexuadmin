import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Home/Home.dart';
import '../profile/profile_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'login_screen.dart';
// state is EmptyLoginState? const Center(child: CircularProgressIndicator(),) :
class LoginCheck extends StatelessWidget {
  const LoginCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit,AuthMainState>(
        builder: (context,state) {
          if(state is EmptyLoginState){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(FirebaseAuth.instance.currentUser == null){
            return  LoginScreen();
          }else{
            return const Admin();}
        }
    );
  }
}
