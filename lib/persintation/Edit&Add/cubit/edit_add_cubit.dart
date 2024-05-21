
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'dart:io';

part 'edit_add_state.dart';

class EditAddCubit extends Cubit<EditAddState> {
  EditAddCubit() : super(EditAddInitial());

  Future<void> forgetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ResetSuccess());
    } catch (e) {
      emit(ResetError(errorMessage: e.toString()));
    }
  }

  Future<void> createAccount(String email, String password, String name,String Photo) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update the user's display name using the new method
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
        print('User display name updated to: ${user!.displayName}');
      }

      emit(CreateAccountSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Failed with error code: ${e.code}');
        print(e.message);
      }
      emit(CreateAccountFailure(e.message));
    } catch (e) {
      print(e);
      emit(CreateAccountFailure(e.toString()));
    }

  }

  String? getimage;

  addProfileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String fileName = result.files.first.path!;
      // Upload file
      final pickedFile = File(fileName);
      await FirebaseStorage.instance.ref('uploads/1').putFile(pickedFile);

      getimage = await FirebaseStorage.instance
          .ref('uploads/1')
          .getDownloadURL();
      FirebaseFirestore.instance
          .collection("Profile")
          .doc(FirebaseAuth.instance.currentUser!.photoURL)
          .update({"image": getimage!});
    }
  }


}
// emit(AddImageMyProfileState());
