part of 'quiz_check_cubit.dart';

@immutable
abstract class QuizCheckState {}

class QuizCheckInitial extends QuizCheckState {}

class QuizCheckLoading extends QuizCheckState {}

class QuizCheckSucceed extends QuizCheckState {
  final List<QuizCheck> quizChecks;
  final String grade;
  final int attempted;
  final int correct;
  final int precentage;
  final Color color;
  QuizCheckSucceed({
    required this.quizChecks,
    required this.grade,
    required this.attempted,
    required this.correct,
    required this.precentage,
    required this.color,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuizCheckSucceed &&
        listEquals(other.quizChecks, quizChecks) &&
        other.grade == grade &&
        other.attempted == attempted &&
        other.correct == correct &&
        other.precentage == precentage &&
        other.color == color;
  }

  @override
  int get hashCode {
    return quizChecks.hashCode ^
        grade.hashCode ^
        attempted.hashCode ^
        correct.hashCode ^
        precentage.hashCode ^
        color.hashCode;
  }

  @override
  String toString() {
    return 'QuizCheckSucceed(quizChecks: $quizChecks, grade: $grade, attempted: $attempted, correct: $correct, precentage: $precentage, color: $color)';
  }
}

class QuizCheckFailed extends QuizCheckState {
  final String errorMsg;
  QuizCheckFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuizCheckFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'QuizCheckFailed(errorMsg: $errorMsg)';
}
