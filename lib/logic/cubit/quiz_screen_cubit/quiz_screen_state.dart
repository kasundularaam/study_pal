part of 'quiz_screen_cubit.dart';

@immutable
abstract class QuizScreenState {}

class QuizScreenInitial extends QuizScreenState {}

class QuizScreenLoading extends QuizScreenState {}

class QuizScreenLoaded extends QuizScreenState {
  final List<Question> quizList;
  QuizScreenLoaded({
    required this.quizList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuizScreenLoaded && listEquals(other.quizList, quizList);
  }

  @override
  int get hashCode => quizList.hashCode;

  @override
  String toString() => 'QuizScreenLoaded(quiZList: $quizList)';
}

class QuizScreenNoResults extends QuizScreenState {
  final String message;
  QuizScreenNoResults({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuizScreenNoResults && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'QuizScreenNoResults(message: $message)';
}

class QuizScreenFailed extends QuizScreenState {
  final String errorMessage;
  QuizScreenFailed({
    required this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuizScreenFailed && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;

  @override
  String toString() => 'QuizScreenFailed(errorMessage: $errorMessage)';
}
