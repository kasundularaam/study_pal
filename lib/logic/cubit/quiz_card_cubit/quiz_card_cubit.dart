import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'quiz_card_state.dart';

class QuizCardCubit extends Cubit<QuizCardState> {
  QuizCardCubit() : super(QuizCardInitial());

  Future<void> checkAnswer(
      {required String correctAnswer, required String selectedAnswer}) async {
    if (selectedAnswer == correctAnswer) {
      emit(QuizCardCorrect());
    } else if (selectedAnswer == "") {
      emit(QuizCardInitial());
    } else {
      emit(QuizCardWrong(correctAnswer: correctAnswer));
    }
  }
}
