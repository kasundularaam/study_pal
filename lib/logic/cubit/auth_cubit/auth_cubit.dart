import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> checkUserStatus() async {
    try {
      emit(AuthLoading(loadingMsg: "Loading..."));
      await Future.delayed(Duration(seconds: 1));
      bool userStatus = FirebaseAuthRepo.checkUserStatus();
      String _statusMsg;
      if (userStatus) {
        _statusMsg = "Loading Your Data...";
      } else {
        _statusMsg = "Please log in befor starting..!";
      }
      emit(AuthCheckUserStatus(userStatus: userStatus, statusMsg: _statusMsg));
    } catch (e) {
      emit(AuthFailed(errorMsg: e.toString()));
    }
  }
}
