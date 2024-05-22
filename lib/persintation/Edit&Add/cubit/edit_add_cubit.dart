import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'edit_add_state.dart';

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
  final Reference _reference = FirebaseStorage.instance.ref();
  Future<UserCredential> createAccount(String email, String password,
      String name, String getimage, String department) async {
    try {
      // Create user with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String imageUrl = "";
      if(SelectImage!=null){
        String fileName = basename(SelectImage!.path);
        Reference fire=_reference.child('uploads/$fileName');
        UploadTask uploadTask = fire.putFile(SelectImage!);
        TaskSnapshot taskSnapshot = await uploadTask;
        imageUrl = await taskSnapshot.ref.getDownloadURL();
   }
      // Upload image and get URL
      // await _uploadImage(File(getimage));

      // Update user profile in Firestore
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        user = FirebaseAuth.instance.currentUser;

        await FirebaseFirestore.instance
            .collection("Profile")
            .doc(user!.uid)
            .set({
          'name': name,
          'user_type': "doctor",
          'image': imageUrl,
          'email':email,
          'department': department,
        }, SetOptions(merge: true));
      }

      emit(CreateAccountSuccess());

      return userCredential; // Return the UserCredential object
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code}, ${e.message}');
      emit(CreateAccountFailure(e.message));
      throw e;
    } catch (e) {
      print('Exception: $e');
      emit(CreateAccountFailure(e.toString()));
      throw e;
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    try {
      if (!imageFile.existsSync()) {
        throw Exception('File does not exist: ${imageFile.path}');
      }

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('uploads/${imageFile.path.split('/').last}');
      await storageRef.putFile(imageFile);
      String downloadUrl = await storageRef.getDownloadURL();
      print('Image uploaded successfully: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }
  File? SelectImage;
  Future<void> addProfileImage() async {
    try {
      emit(Profileloading());
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        SelectImage = File(image.path) ;




      }
      emit(ProfileSucces());

    } catch (e) {
      print('Error adding profile image: $e');
    }
  }

  Future<String> uploadImage(File file) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child("profile_images/${file.path.split('/').last}");
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    return await taskSnapshot.ref.getDownloadURL();
  }
}


