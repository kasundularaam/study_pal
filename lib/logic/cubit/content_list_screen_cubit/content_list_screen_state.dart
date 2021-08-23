part of 'content_list_screen_cubit.dart';

@immutable
abstract class ContentListScreenState {}

class ContentListScreenInitial extends ContentListScreenState {}

class ContentListScreenLoading extends ContentListScreenState {}

class ContentListScreenLoaded extends ContentListScreenState {
  final List<Content> contentList;
  ContentListScreenLoaded({
    required this.contentList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContentListScreenLoaded &&
        listEquals(other.contentList, contentList);
  }

  @override
  int get hashCode => contentList.hashCode;

  @override
  String toString() => 'ContentListScreenLoaded(contentList: $contentList)';
}

class ContentListScreenNoResult extends ContentListScreenState {
  final String message;
  ContentListScreenNoResult({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContentListScreenNoResult && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'ContentListScreenNoResult(message: $message)';
}

class ContentListScreenFailed extends ContentListScreenState {
  final String errorMsg;
  ContentListScreenFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContentListScreenFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'ContentListScreenFailed(errorMsg: $errorMsg)';
}
