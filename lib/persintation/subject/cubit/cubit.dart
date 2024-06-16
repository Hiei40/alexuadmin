import 'package:alexuadmin/persintation/subject/cubit/state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Model/SubjectModel.dart';

class SubjectCubit extends Cubit<SubjectState> {
  SubjectCubit() : super(SubjectInitial());

  static SubjectCubit get(context) => BlocProvider.of(context);

  List<Course> course = [];

  Future<void> fetchData() async {
    try {
      emit(SubjectLoaded());
      CollectionReference home =
          FirebaseFirestore.instance.collection("SubjectswitTeacher");
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

  List<Map<String, dynamic>> surveys = [];

  Future<void> fetchSurvey(String subject) async {
    try {
      emit(SurveyLoaded());

      // Create the query
      Query<Map<String, dynamic>> surveyQuery = FirebaseFirestore.instance
          .collection("Survey")
          .where("Subject", isEqualTo: subject);

      // Fetch the data from the query
      QuerySnapshot snapshot = await surveyQuery.get();

      surveys.clear();

      snapshot.docs.forEach((element) {
        // Directly add the data as Map<String, dynamic> to the list
        surveys.add(element.data() as Map<String, dynamic>);
      });

      emit(SurveySuccefull());
    } catch (e) {
      emit(SurveyError(error: e.toString()));
    }
  }

  List<Map<String, dynamic>> FeedBack = [];

  Future<void> FeedBackFetch(String subject) async {
    try {
      emit(FeedBackLoaded());

      // Create the query
      Query<Map<String, dynamic>> FeedBackSurvey = FirebaseFirestore.instance
          .collection("FeedBack")
          .where("NameofSubject", isEqualTo: subject);

      // Fetch the data from the query
      QuerySnapshot snapshot = await FeedBackSurvey.get();

      FeedBack.clear();

      snapshot.docs.forEach((element) {
        // Directly add the data as Map<String, dynamic> to the list
        FeedBack.add(element.data() as Map<String, dynamic>);
      });

      emit(FeedBackSuccefull());
    } catch (e) {
      emit(FeedBackError(error: e.toString()));
    }
  }

  List<Map<String, dynamic>> Progress = [];
  List allIdAbsences = [];
  getAbsences() async {
    emit(AbsencesLoadState());
    await FirebaseFirestore.instance
        .collection("Attendance")
        .get()
        .then((value) {
      value.docs.forEach((data) {
        allIdAbsences.add(data.id);
      });
    });
    emit(AbsencesState());
  }

  List warningList = [];
  warning() async {
    emit(AbsencesLoadState());

    await FirebaseFirestore.instance
        .collection("Attendance")
        .where("worning", isGreaterThan: 1)
        .get()
        .then((value) {
      warningList.clear();
      value.docs.forEach((data) {
        if (data["worning"] > 1) {
          warningList.add(data["Email"]);
        }
      });
    });
    emit(WarningLoadState());
  }

  List allIdAbsence = [];
  getAbsence(String Subject) async {
    emit(AbsenceLoadState());

    await FirebaseFirestore.instance
        .collectionGroup("Abscence")
        .get()
        .then((value) {
      allIdAbsence.clear();
      value.docs.forEach((element) {
        if (element.data()["Subject"] == Subject) print(element.data());
        allIdAbsence.add(element.data());
      });
    });

    emit(AbsenceState());
  }

  Future<void> ProgressFetch(String Level) async {
    try {
      emit(ProgressLoaded());

      // Create the query
      Query<Map<String, dynamic>> surveyQuery = FirebaseFirestore.instance
          .collection("Profile")
          .where("Level", isEqualTo: Level);

      // Fetch the data from the query
      QuerySnapshot snapshot = await surveyQuery.get();

      Progress.clear();

      snapshot.docs.forEach((element) {
        // Directly add the data as Map<String, dynamic> to the list
        Progress.add(element.data() as Map<String, dynamic>);
      });

      emit(ProgressSuccefull());
    } catch (e) {
      emit(ProgressError(error: e.toString()));
    }
  }

  List<Map<String, dynamic>> studentProgress =
      []; // Declare studentProgress list

  Future<void> ProgressFetchStudent(String Email, String Subject) async {
    try {
      emit(ProgressProfileLoaded());

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Progress")
          .where("Subject", isEqualTo: Subject)
          .where("StudentEmail", isEqualTo: Email)
          .get(); // Added get() here

      studentProgress.clear();

      querySnapshot.docs.forEach((element) {
        studentProgress.add(element.data() as Map<String, dynamic>);
      });

      emit(ProgressProfileSuccefull());
    } catch (e) {
      emit(ProgressProfileError(error: e.toString()));
    }
  }

  Future<void> addGrades(String Subject, String StudentEmail, int Final,
      int MedtermGrad, int YearWork, int CreditHourForStudent,String Level) async {
    try {
      final postCollection = FirebaseFirestore.instance.collection('Progress');
      await postCollection.add({
        'StudentEmail': StudentEmail,
        'Subject': Subject,
        'Final': Final,
        'MedtermGrad': MedtermGrad,
        'YearWork': YearWork,
        'total': Final + MedtermGrad + YearWork,
        'CreditHourForStudent': CreditHourForStudent,
        'Level': Level
      });
      emit(GradeAddedSuccess());
    } catch (e) {
      emit(GradeAddedError(error: e.toString()));
    }
  }
}
