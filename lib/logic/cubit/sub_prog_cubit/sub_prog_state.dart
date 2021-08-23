part of 'sub_prog_cubit.dart';

@immutable
abstract class SubProgState {}

class SubProgInitial extends SubProgState {}

class SubProgLoading extends SubProgState {}

class SubProgLoaded extends SubProgState {
  final int contentCount;
  final int fireContentCount;
  SubProgLoaded({
    required this.contentCount,
    required this.fireContentCount,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubProgLoaded &&
        other.contentCount == contentCount &&
        other.fireContentCount == fireContentCount;
  }

  @override
  int get hashCode => contentCount.hashCode ^ fireContentCount.hashCode;

  @override
  String toString() =>
      'SubProgLoaded(contentCount: $contentCount, fireContentCount: $fireContentCount)';
}

class SubProgFailed extends SubProgState {
  final String errorMsg;
  SubProgFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubProgFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'SubProgFailed(errorMsg: $errorMsg)';
}
