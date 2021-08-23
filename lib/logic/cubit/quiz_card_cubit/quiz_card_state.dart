part of 'quiz_card_cubit.dart';

@immutable
abstract class QuizCardState {}

class QuizCardInitial extends QuizCardState {}

class QuizCardCorrect extends QuizCardState {}

class QuizCardWrong extends QuizCardState {
  final String correctAnswer;
  QuizCardWrong({
    required this.correctAnswer,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuizCardWrong && other.correctAnswer == correctAnswer;
  }

  @override
  int get hashCode => correctAnswer.hashCode;

  @override
  String toString() => 'QuizCardWrong(correctAnswer: $correctAnswer)';
}
