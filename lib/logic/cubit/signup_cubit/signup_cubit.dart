import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_auth_repo.dart';
import 'package:study_pal/data/value%20validator/auth_value_validator.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<void> signUpNewUser(
      {required String email,
      required String name,
      required String password}) async {
    String emailFeedback = ValueValidator.validateEmail(email: email);
    String passwordFeedback =
        ValueValidator.validatePassword(password: password);
    String nameFeedback = ValueValidator.validateName(name: name);
    if (nameFeedback == ValueValidator.validName) {
      if (emailFeedback == ValueValidator.validEmail) {
        if (passwordFeedback == ValueValidator.validPassword) {
          try {
            emit(SignupLoading(loadingMsg: "Creating new account..."));
            await FirebaseAuthRepo.signUpNewUser(
                email: email, name: name, password: password);
            emit(SignupSucceed());
          } catch (e) {
            emit(SignupFailed(errorMsg: e.toString()));
          }
        } else {
          emit(SignupWithInvalidValue(errorMsg: passwordFeedback));
        }
      } else {
        emit(SignupWithInvalidValue(errorMsg: emailFeedback));
      }
    } else {
      emit(SignupWithInvalidValue(errorMsg: nameFeedback));
    }
  }
}
