part of 'today_works_cubit.dart';

@immutable
abstract class TodayWorksState {}

class TodayWorksInitial extends TodayWorksState {}

class TodayWorksLoading extends TodayWorksState {
  final String loadingMsg;
  TodayWorksLoading({
    required this.loadingMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodayWorksLoading && other.loadingMsg == loadingMsg;
  }

  @override
  int get hashCode => loadingMsg.hashCode;

  @override
  String toString() => 'TodayWorksLoading(loadingMsg: $loadingMsg)';
}

class TodayWorksLoaded extends TodayWorksState {
  final String workedTime;
  final List<PieDataModel> pieDataList;
  TodayWorksLoaded({
    required this.workedTime,
    required this.pieDataList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodayWorksLoaded &&
        other.workedTime == workedTime &&
        listEquals(other.pieDataList, pieDataList);
  }

  @override
  int get hashCode => workedTime.hashCode ^ pieDataList.hashCode;

  @override
  String toString() =>
      'TodayWorksLoaded(workedTime: $workedTime, pieDataList: $pieDataList)';
}

class TodayWorksNoWork extends TodayWorksState {
  final String message;
  TodayWorksNoWork({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodayWorksNoWork && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'TodayWorksNoWork(message: $message)';
}

class TodayWorksFailed extends TodayWorksState {
  final String errorMsg;
  TodayWorksFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodayWorksFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'TodayWorksFailed(errorMsg: $errorMsg)';
}
