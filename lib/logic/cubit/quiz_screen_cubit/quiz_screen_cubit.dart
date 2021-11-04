import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/http/http_requests.dart';
import 'package:study_pal/data/models/fire_quiz.dart';
import 'package:study_pal/data/models/question_model.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_quiz_repo.dart';

part 'quiz_screen_state.dart';

class QuizScreenCubit extends Cubit<QuizScreenState> {
  QuizScreenCubit() : super(QuizScreenInitial());

  Future<void> loadQuizList(
      {required String subjectId, required String moduleId}) async {
    try {
      emit(QuizScreenLoading());
      List<Question> filteredList = [];
      List<String> fQuizIds = [];
      List<Question> quizList =
          await HttpRequests.getQuestions(moduleId: moduleId);
      List<FireQuize> fireQuizes = await FirebaseQuizRepo.getFireQuizByMod(
          subjectId: subjectId, moduleId: moduleId);
      fireQuizes.forEach((fireQuiz) {
        fQuizIds.add(fireQuiz.quizId);
      });
      quizList.forEach((quiz) {
        if (!fQuizIds.contains(quiz.id)) {
          filteredList.add(quiz);
        }
      });

      if (filteredList.isNotEmpty) {
        emit(QuizScreenLoaded(quizList: filteredList));
      } else {
        emit(QuizScreenNoResults(
            message:
                "No Quizes Available!\nReset progress to access previous questions..."));
      }
    } catch (e) {
      emit(QuizScreenFailed(errorMessage: e.toString()));
    }
  }

  Future<void> resetProgress(
      {required String subjectId, required String moduleId}) async {
    try {
      emit(QuizScreenLoading());
      await FirebaseQuizRepo.resetProgress(
          subjectId: subjectId, moduleId: moduleId);
      loadQuizList(subjectId: subjectId, moduleId: moduleId);
    } catch (e) {
      emit(QuizScreenFailed(errorMessage: e.toString()));
    }
  }
}
