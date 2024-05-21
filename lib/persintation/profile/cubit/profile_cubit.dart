import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';
// import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  Map<String,dynamic> data = {};
  String ? getimage;
  addProfileImage()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String fileName = result.files.first.path!;
      // Upload file
      final file=File(fileName);
      await FirebaseStorage.instance
          .ref('uploads/1')
          .putFile(file);

      getimage = await FirebaseStorage.instance
          .ref('uploads/1')
          .getDownloadURL();
      FirebaseFirestore.instance
          .collection("Profile")
          .doc(FirebaseAuth.instance.currentUser!.photoURL)
          .update({"image":getimage!});
    }
    emit(AddImageMyProfileState());
  }
  Future<void> MyProfile() async {
    emit(EmptyState());
   await FirebaseFirestore.instance.collection("Profile")
        .doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
          data=value.data()!;
          // print(FirebaseAuth.instance.currentUser!.email);
          // print(data);
    });
    emit(ProfileSucceful());
    }
}