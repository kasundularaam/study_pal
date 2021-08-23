import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_auth_repo.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  Future<void> logOut() async {
    try {
      emit(
        LogoutLoading(loadingMsg: "signing out..."),
      );
      await FirebaseAuthRepo.logOutUser();
      emit(LogoutSucceed());
    } catch (e) {
      emit(LogoutFailed(errorMsg: e.toString()));
    }
  }
}
