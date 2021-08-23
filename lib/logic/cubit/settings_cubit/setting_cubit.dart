import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/http/http_requests.dart';
import 'package:study_pal/data/models/fire_user_model.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_auth_repo.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebse_subject_repo.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());

  Future<void> loadProfileSettings() async {
    try {
      emit(SettingLoading());
      FireUser fireUser = await FirebaseAuthRepo.getUserDetails();
      List<Subject> fireSubjects = await FirebaseSubjectRepo.getSubjects();
      List<Subject> subjects = await HttpRequests.getSubjects();
      emit(
        SettingLoaded(
          fireUser: fireUser,
          fireSubjects: fireSubjects,
          subjects: subjects,
        ),
      );
    } catch (e) {
      emit(SettingFailed(errorMsg: e.toString()));
    }
  }
}
