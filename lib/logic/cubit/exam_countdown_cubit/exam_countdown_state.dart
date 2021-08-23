part of 'exam_countdown_cubit.dart';

@immutable
abstract class ExamCountdownState {}

class ExamCountdownInitial extends ExamCountdownState {}

class ExamCountdownLoading extends ExamCountdownState {}

class ExamCountdownEdit extends ExamCountdownState {
  final bool available;
  ExamCountdownEdit({
    required this.available,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExamCountdownEdit && other.available == available;
  }

  @override
  int get hashCode => available.hashCode;

  @override
  String toString() => 'ExamCountdownEdit(available: $available)';
}

class ExamCountdownRunning extends ExamCountdownState {
  final int examTimeStamp;
  ExamCountdownRunning({
    required this.examTimeStamp,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExamCountdownRunning &&
        other.examTimeStamp == examTimeStamp;
  }

  @override
  int get hashCode => examTimeStamp.hashCode;

  @override
  String toString() => 'ExamCountdownRunning(examTimeStamp: $examTimeStamp)';
}
