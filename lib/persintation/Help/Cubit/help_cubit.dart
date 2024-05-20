import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'help_state.dart';

class HelpCubit extends Cubit<HelpState> {
  HelpCubit() : super(HelpInitial());
  List<Map<String, dynamic>> Help = [];
  List<Map<String, dynamic>> feedbackList = [];
  List<Map<String, dynamic>> surveyList = [];

  // Fetch Help data from Firestore
  void fetchHelpData() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Help').get();
      Help.clear();
      querySnapshot.docs.forEach((QueryDocumentSnapshot doc) {
        Help.add(doc.data() as Map<String, dynamic>);
      });
      emit(HelpDataFetchedSuccessfully());
    } catch (e) {
      emit(HelpDataFetchFailed(error: e.toString()));
    }
  }

  // Fetch Feedback data from Firestore
  void fetchFeedbackData() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('FeedBack').get();
      feedbackList.clear();
      querySnapshot.docs.forEach((QueryDocumentSnapshot doc) {
        feedbackList.add(doc.data() as Map<String, dynamic>);
      });
      emit(FeedbackDataFetchedSuccessfully());
    } catch (e) {
      emit(FeedbackDataFetchFailed(error: e.toString()));
    }
  }

  // Fetch Survey data from Firestore
  void fetchSurveyData() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Survey').get();
      surveyList.clear();
      querySnapshot.docs.forEach((QueryDocumentSnapshot doc) {
        surveyList.add(doc.data() as Map<String, dynamic>);
      });
      emit(SurveyDataFetchedSuccessfully());
    } catch (e) {
      emit(SurveyDataFetchFailed(error: e.toString()));
    }
  }

  // Add Feedback data to Firestore
  void addFeedback(String content, String subject) async {
    try {
      final postCollection = FirebaseFirestore.instance.collection('FeedBack');
      await postCollection.add({
        'content': content,
        'NameofSubject': subject,
      });
      emit(HelpAddedSuccessfully());
    } catch (e) {
      emit(HelpAddingFailed(error: e.toString()));
    }
  }

  // Add Survey data to Firestore
  void addSurvey(String content, String subject) async {
    try {
      final postCollection = FirebaseFirestore.instance.collection('Survey');
      await postCollection.add({
        'content': content,
        'NameofSubject': subject,
      });
      emit(HelpAddedSuccessfully());
    } catch (e) {
      emit(HelpAddingFailed(error: e.toString()));
    }
  }
}
