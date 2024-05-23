import 'package:alexuadmin/persintation/subject/cubit/state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Model/SubjectModel.dart';
import 'package:alexuadmin/persintation/subject/cubit/state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Model/SubjectModel.dart';
import '../Model/SubjectModel.dart';

class SubjectCubit extends Cubit<SubjectState> {
  SubjectCubit() : super(SubjectInitial());

  static SubjectCubit get(context) => BlocProvider.of(context);

  List<Course> course = [];

  Future<void> fetchData() async {
    try {
      emit(SubjectLoaded());

      CollectionReference home = FirebaseFirestore.instance.collection("SubjectswitTeacher");
      QuerySnapshot snapshot = await home.get();

      course.clear();

      snapshot.docs.forEach((element) {
        // Explicitly cast element.data() to Map<String, dynamic>
        course.add(Course.fromJson(element.data() as Map<String, dynamic>));
      });

      emit(SubjectSuccefull());
    } catch (e) {
      emit(SubjectError(error: e.toString()));
    }
  }
}


  // Future<void> MyProfile() async {
  //   emit(EmptyState());
  //   await FirebaseFirestore.instance.collection("Profile")
  //       .doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
  //        MySubject(value.data()!["department"]);
  //   });
  //   emit(MyProfileSuccefull());
  // }
  // Future<void> MySubject(department) async {
  //   emit(EmptyState());
  //   await FirebaseFirestore.instance.collection("Subject")
  //       .doc(department).get().then((value) {
  //         listSubject=[];
  //     listSubject=value.data()!["subjects"];
  //     // print(FirebaseAuth.instance.currentUser!.email);
  //     // print(data);
  //   });
  //   emit(SubjectSuccefull());
  // }

// Future<void> MySubject(department) async {
//   emit(EmptyState());
//   await FirebaseFirestore.instance.collection("Subject")
//       .doc(department).get().then((value) {
//     listSubject=[];
//     listSubject=value.data()!["subjects"];
//     // print(FirebaseAuth.instance.currentUser!.email);
//     // print(data);
//   });
//   emit(SubjectSuccefull());
// }