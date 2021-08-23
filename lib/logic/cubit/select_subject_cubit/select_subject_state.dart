part of 'select_subject_cubit.dart';

@immutable
abstract class SelectSubjectState {}

class SelectSubjectInitial extends SelectSubjectState {}

class SelectedSubjectLoading extends SelectSubjectState {
  final String loadingMsg;
  SelectedSubjectLoading({
    required this.loadingMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SelectedSubjectLoading && other.loadingMsg == loadingMsg;
  }

  @override
  int get hashCode => loadingMsg.hashCode;

  @override
  String toString() => 'SelectedSubjectLoading(loadingMsg: $loadingMsg)';
}

class SelectedSubjectSucceed extends SelectSubjectState {}

class SelectedSubjectFailed extends SelectSubjectState {
  final String errorMsg;
  SelectedSubjectFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SelectedSubjectFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'SelectedSubjectFailed(errorMsg: $errorMsg)';
}
