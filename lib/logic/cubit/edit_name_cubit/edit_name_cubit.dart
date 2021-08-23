import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_auth_repo.dart';

part 'edit_name_state.dart';

class EditNameCubit extends Cubit<EditNameState> {
  EditNameCubit() : super(EditNameInitial());

  Future<void> updateUserName({required newName}) async {
    try {
      emit(EditNameLoading());
      await FirebaseAuthRepo.updateUserName(newName: newName);
      emit(EditNameSucceed(message: "Name changed!"));
    } catch (e) {
      emit(EditNameFailed(errorMsg: e.toString()));
    }
  }
}
