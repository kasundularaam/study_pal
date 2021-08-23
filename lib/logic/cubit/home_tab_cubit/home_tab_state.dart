part of 'home_tab_cubit.dart';

@immutable
abstract class HomeTabState {}

class HomeTabInitial extends HomeTabState {}

class HomeTabLoading extends HomeTabState {}

class HomeTabLoaded extends HomeTabState {
  final List<Subject> subjectList;
  HomeTabLoaded({
    required this.subjectList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeTabLoaded && listEquals(other.subjectList, subjectList);
  }

  @override
  int get hashCode => subjectList.hashCode;

  @override
  String toString() => 'HomeTabLoaded(subjectList: $subjectList)';
}

class HomeTabFailed extends HomeTabState {
  final String errorMsg;
  HomeTabFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeTabFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'HomeTabFailed(errorMsg: $errorMsg)';
}
