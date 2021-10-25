import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/models/fire_quiz.dart';
import 'package:study_pal/data/models/quiz_check_model.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_quiz_repo.dart';

part 'quiz_check_state.dart';

class QuizCheckCubit extends Cubit<QuizCheckState> {
  QuizCheckCubit() : super(QuizCheckInitial());

  Future<void> checkQuizes(
      {required List<QuizCheck> quizChecks,
      required String subjectId,
      required String moduleId}) async {
    try {
      emit(QuizCheckLoading());
      List<FireQuize> fireQuizes = [];
      quizChecks.forEach((quizCheck) {
        bool isCorrect = false;
        if (quizCheck.checkedAnswer == quizCheck.correctAnswer) {
          isCorrect = true;
        }
        fireQuizes.add(
          FireQuize(
            quizId: quizCheck.id,
            subjectId: subjectId,
            moduleId: moduleId,
            isCorrect: isCorrect,
          ),
        );
      });
      await FirebaseQuizRepo.uploadQuizes(fireQuizes: fireQuizes);
      emit(QuizCheckSucceed(fireQuizes: fireQuizes, quizChecks: quizChecks));
    } catch (e) {
      emit(QuizCheckFailed(errorMsg: e.toString()));
    }
  }
}
