import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/models/fire_user_model.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_auth_repo.dart';

part 'profile_top_card_state.dart';

class ProfileTopCardCubit extends Cubit<ProfileTopCardState> {
  ProfileTopCardCubit() : super(ProfileTopCardInitial());

  Future<void> getUserDetails() async {
    try {
      emit(ProfileTopCardLoading());
      FireUser fireUser = await FirebaseAuthRepo.getUserDetails();
      emit(ProfileTopCardLoaded(fireUser: fireUser));
    } catch (e) {
      emit(ProfileTopCardFailed(errorMsg: e.toString()));
    }
  }
}
