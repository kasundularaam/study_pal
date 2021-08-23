import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_auth_repo.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  Future<void> changePassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      emit(ChangePasswordLoading());
      await FirebaseAuthRepo.changePassword(
          currentPassword: currentPassword, newPassword: newPassword);
      emit(ChangePasswordSucceed(message: "Password changed!"));
    } catch (e) {
      emit(ChangePasswordFailed(errorMsg: e.toString()));
    }
  }
}
