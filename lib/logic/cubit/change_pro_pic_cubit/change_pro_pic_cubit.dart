import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/models/fire_user_model.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_auth_repo.dart';
import 'package:study_pal/data/repositories/local_repo.dart';

part 'change_pro_pic_state.dart';

class ChangeProPicCubit extends Cubit<ChangeProPicState> {
  ChangeProPicCubit() : super(ChangeProPicInitial());

  Future<void> loaddProfilePic() async {
    try {
      emit(ChangeProPicLoading());
      FireUser user = await FirebaseAuthRepo.getUserDetails();
      emit(ChangeProPicLoaded(profileImage: user.profilePic));
    } catch (e) {
      emit(ChangeProPicFailed(errorMsg: e.toString()));
    }
  }

  Future<void> uploadProPic() async {
    try {
      File imageFile = await LocalRepo.pickImage();
      emit(ChangeProPicUploading());
      await FirebaseAuthRepo.uploadProfilePic(imageFile: imageFile);
      emit(ChangeProPicUploaded());
      loaddProfilePic();
    } catch (e) {
      emit(ChangeProPicFailed(errorMsg: e.toString()));
    }
  }
}
