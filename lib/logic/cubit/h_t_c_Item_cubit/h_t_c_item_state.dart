part of 'h_t_c_item_cubit.dart';

@immutable
abstract class HTCItemState {}

class HTCItemInitial extends HTCItemState {}

class HTCItemLoading extends HTCItemState {}

class HTCItemLoaded extends HTCItemState {
  final int contentCount;
  final int fireContentCount;
  HTCItemLoaded({
    required this.contentCount,
    required this.fireContentCount,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HTCItemLoaded &&
        other.contentCount == contentCount &&
        other.fireContentCount == fireContentCount;
  }

  @override
  int get hashCode => contentCount.hashCode ^ fireContentCount.hashCode;

  @override
  String toString() =>
      'HTCItemLoaded(contentCount: $contentCount, fireContentCount: $fireContentCount)';
}

class HTCItemFailed extends HTCItemState {
  final String errorMsg;
  HTCItemFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HTCItemFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'HTCItemFailed(errorMsg: $errorMsg)';
}
