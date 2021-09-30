import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/models/fire_content.dart';
import 'package:study_pal/data/models/fire_user_model.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_auth_repo.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_content_repo.dart';

part 'work_card_list_state.dart';

class WorkCardListCubit extends Cubit<WorkCardListState> {
  WorkCardListCubit() : super(WorkCardListInitial());

  Future<void> loadFireContentList() async {
    try {
      emit(WorkCardListLoading());
      List<FireContent> fireContents =
          await FirebaseContentRepo.getFireContents();
      FireUser fireUser = await FirebaseAuthRepo.getUserDetails();

      emit(WorkCardListLoaded(
          fireContents: fireContents, profileImage: fireUser.profilePic));
    } catch (e) {
      emit(WorkCardListFailed(errorMsg: e.toString()));
    }
  }
}
