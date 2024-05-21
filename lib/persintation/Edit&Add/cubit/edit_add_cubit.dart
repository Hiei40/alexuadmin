import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'edit_add_state.dart';

class EditAddCubit extends Cubit<EditAddState> {
  EditAddCubit() : super(EditAddInitial());
  Future<void>ForgetPassword(String Email)async {
 await FirebaseAuth.instance.sendPasswordResetEmail(
          email: Email

      );
 emit(ResetSucces());

    }
  }


