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
  Future<void> announcement() async {
    try {
      QuerySnapshot announcement = await FirebaseFirestore.instance
          .collection("Announcement")
          .get();
      data2.clear();

      announcement.docs.forEach((element) {

        data2.add(Announcement.fromJson(element.data() as Map<String, dynamic>));
      });
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }
  void Addannouncement(String News) async {
      final postCollection = FirebaseFirestore.instance.collection('Announcement');
      await postCollection.add({
        'Name': "Dr${FirebaseAuth.instance.currentUser?.displayName}",
        "News":News,
        "Photo":FirebaseAuth.instance.currentUser?.photoURL,
      });

  }
}
