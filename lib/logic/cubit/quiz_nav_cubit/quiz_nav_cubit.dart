import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/models/quiz_check_model.dart';

part 'quiz_nav_state.dart';

class QuizNavCubit extends Cubit<QuizNavState> {
  QuizNavCubit() : super(QuizNavAttempt());

  void checkAnswers({required List<QuizCheck> quizChecks}) {
    emit(QuizNavCheck(quizChecks: quizChecks));
  }
}
