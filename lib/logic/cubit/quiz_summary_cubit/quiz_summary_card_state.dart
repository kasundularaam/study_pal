part of 'quiz_summary_card_cubit.dart';

@immutable
abstract class QuizSummaryCardState {}

class QuizSummaryCardInitial extends QuizSummaryCardState {}

class QuizSummaryLoading extends QuizSummaryCardState {}

class QuizSummaryLoaded extends QuizSummaryCardState {
  final List<Subject> subjects;
  QuizSummaryLoaded({
    required this.subjects,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuizSummaryLoaded && listEquals(other.subjects, subjects);
  }

  @override
  int get hashCode => subjects.hashCode;

  @override
  String toString() => 'QuizSummaryLoaded(subjects: $subjects)';
}

class QuizSummaryFailed extends QuizSummaryCardState {}
