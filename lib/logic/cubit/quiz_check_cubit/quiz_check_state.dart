part of 'quiz_check_cubit.dart';

@immutable
abstract class QuizCheckState {}

class QuizCheckInitial extends QuizCheckState {}

class QuizCheckLoading extends QuizCheckState {}

class QuizCheckSucceed extends QuizCheckState {
  final List<FireQuize> fireQuizes;
  final List<QuizCheck> quizChecks;
  QuizCheckSucceed({
    required this.fireQuizes,
    required this.quizChecks,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuizCheckSucceed &&
        listEquals(other.fireQuizes, fireQuizes) &&
        listEquals(other.quizChecks, quizChecks);
  }

  @override
  int get hashCode => fireQuizes.hashCode ^ quizChecks.hashCode;

  @override
  String toString() =>
      'QuizCheckSucceed(fireQuizes: $fireQuizes, quizChecks: $quizChecks)';
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
