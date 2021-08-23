part of 'change_subjects_cubit.dart';

@immutable
abstract class ChangeSubjectsState {}

class ChangeSubjectsInitial extends ChangeSubjectsState {}

class ChangeSubjectsLoading extends ChangeSubjectsState {}

class ChangeSubjectsSucceed extends ChangeSubjectsState {
  final String message;
  ChangeSubjectsSucceed({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChangeSubjectsSucceed && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'ChangeSubjectsSucceed(message: $message)';
}

class ChangeSubjectsFailed extends ChangeSubjectsState {
  final String errorMsg;
  ChangeSubjectsFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChangeSubjectsFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'ChangeSubjectsFailed(errorMsg: $errorMsg)';
}
