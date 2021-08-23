import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/http/http_requests.dart';
import 'package:study_pal/data/models/question_model.dart';

part 'quiz_screen_state.dart';

class QuizScreenCubit extends Cubit<QuizScreenState> {
  QuizScreenCubit() : super(QuizScreenInitial());

  Future<void> loadQuizList({required String moduleId}) async {
    try {
      emit(QuizScreenLoading());
      List<Question> quizList =
          await HttpRequests.getQuestions(moduleId: moduleId);
      if (quizList.isNotEmpty) {
        emit(QuizScreenLoaded(quizList: quizList));
      } else {
        emit(QuizScreenNoResults(message: "No Results Found"));
      }
    } catch (e) {
      emit(QuizScreenFailed(errorMessage: e.toString()));
    }
  }
}
