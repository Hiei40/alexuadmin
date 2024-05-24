import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Home/Home.dart';
import '../login_screen.dart';
import 'state.dart';

class AuthCubit extends Cubit<AuthMainState> {
  AuthCubit() : super(AuthInitState());

  String userType = "customer";
  bool see = true;

  static AuthCubit get(context) => BlocProvider.of(context);

  userTypeCubit(value) {
    userType = value;
    emit(UserTypeState());
  }

  signInCubit(BuildContext context, String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      Navigator.of(context).pushReplacementNamed("Home");

    } on FirebaseAuthException catch (e) {
      print("error");
    }
    emit(SignInState());
  }


  signUpCubit(
      BuildContext context, emailAddress, password, name, userType) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Admin()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    createProf(FirebaseAuth.instance.currentUser!.uid, name, "student");
    emit(SignUpState());
  }

  createProf(uid, name, userType) async {
    await FirebaseFirestore.instance.collection("Profile").doc(uid).set(
      {
        "name": name,
        "type": userType,
      },
    );
  }

  createShop(uid, name) async {
    await FirebaseFirestore.instance.collection("shope").doc(uid).set(
      {
        "name": name,
      },
    );
  }

  seeCubit() {
    see = !see; // Toggle the boolean value
    emit(SeeState()); // Emit state change
  }

  void signOutAndNavigateToHome(BuildContext context) async {
    // Sign out
    await FirebaseAuth.instance.signOut();

    // Navigate to Home
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
  }
}
