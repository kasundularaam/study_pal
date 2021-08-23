part of 'select_sub_list_cubit.dart';

@immutable
abstract class SelectSubListState {}

class SelectSubListInitial extends SelectSubListState {}

class SelectSubjectLoading extends SelectSubListState {
  final String loadingMsg;
  SelectSubjectLoading({
    required this.loadingMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SelectSubjectLoading && other.loadingMsg == loadingMsg;
  }

  @override
  int get hashCode => loadingMsg.hashCode;

  @override
  String toString() => 'SelectSubjectLoading(loadingMsg: $loadingMsg)';
}

class SelectSubjectLoaded extends SelectSubListState {
  final List<Subject> subjectList;
  SelectSubjectLoaded({
    required this.subjectList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SelectSubjectLoaded &&
        listEquals(other.subjectList, subjectList);
  }

  @override
  int get hashCode => subjectList.hashCode;

  @override
  String toString() => 'SelectSubjectLoaded(subjectList: $subjectList)';
}

class SelectSubjectFailed extends SelectSubListState {
  final String errorMsg;
  SelectSubjectFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SelectSubjectFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'SelectSubjectFailed(errorMsg: $errorMsg)';
}
