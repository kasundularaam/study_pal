part of 'quiz_nav_cubit.dart';

@immutable
abstract class QuizNavState {}

class QuizNavAttempt extends QuizNavState {}

class QuizNavCheck extends QuizNavState {
  final List<QuizCheck> quizChecks;
  QuizNavCheck({
    required this.quizChecks,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuizNavCheck && listEquals(other.quizChecks, quizChecks);
  }

  @override
  int get hashCode => quizChecks.hashCode;

  @override
  String toString() => 'QuizNavCheck(quizChecks: $quizChecks)';
}
