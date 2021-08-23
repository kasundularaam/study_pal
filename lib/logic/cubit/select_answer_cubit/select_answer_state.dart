part of 'select_answer_cubit.dart';

@immutable
abstract class SelectAnswerState {}

class SelectAnswerInitial extends SelectAnswerState {}

class SelectAnswerSelect extends SelectAnswerState {
  final String selectedAnswer;
  SelectAnswerSelect({
    required this.selectedAnswer,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SelectAnswerSelect &&
        other.selectedAnswer == selectedAnswer;
  }

  @override
  int get hashCode => selectedAnswer.hashCode;

  @override
  String toString() => 'SelectAnswerSelect(selectedAnswer: $selectedAnswer)';
}
