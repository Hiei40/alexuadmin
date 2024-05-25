import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../Model/Announcement.dart';
import '../../../Model/HomeModel.dart'; // consistent import
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  List<Subject> data = [];

  Future<void> fetchData() async {
    try {
      emit(HomeDataLoaded());
      CollectionReference Home =
      FirebaseFirestore.instance.collection("HomeAdmin");
      QuerySnapshot HomeData =
      await Home.orderBy("id", descending: false).get();
      data.clear();

      HomeData.docs.forEach((element) {
        // Explicitly cast element.data() to Map<String, dynamic>
        data.add(Subject.fromJson(element.data() as Map<String, dynamic>));
      });
      emit(HomeDataSucceful());
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }


  List<Announcement>data2 = [];
  Future<void> addAnnouncement(String news) async {
    try {
      final postCollection = FirebaseFirestore.instance.collection('Announcement');
      await postCollection.add({
        'Name': "Admin",
        'News': news,
        'Photo': 'https://firebasestorage.googleapis.com/v0/b/alexu-a9210.appspot.com/o/Admin-Profile-Vector-PNG-Clipart.png?alt=media&token=111f768b-7e41-4534-b7bd-4e1f46c69c14',
      });
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }
  Future<void> fetchAll() async {
    try {
      emit(HomeDataLoaded());
      QuerySnapshot AllSubject =await
      FirebaseFirestore.instance.collection("HomeAdmin").get();

      data.clear();

      AllSubject.docs.forEach((element) {
        // Explicitly cast element.data() to Map<String, dynamic>
        data.add(Subject.fromJson(element.data() as Map<String, dynamic>));
      });
      emit(HomeDataSucceful());
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }
}
