part of 'module_screen_cubit.dart';

@immutable
abstract class ModuleScreenState {}

class ModuleScreenInitial extends ModuleScreenState {}

class ModuleScreenLoading extends ModuleScreenState {}

class ModuleScreenLoaded extends ModuleScreenState {
  final List<Content> contentList;
  ModuleScreenLoaded({
    required this.contentList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModuleScreenLoaded &&
        listEquals(other.contentList, contentList);
  }

  @override
  int get hashCode => contentList.hashCode;

  @override
  String toString() => 'ContentScreenLoaded(contentList: $contentList)';
}

class ModuleScreenNoResult extends ModuleScreenState {
  final String message;
  ModuleScreenNoResult({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModuleScreenNoResult && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'ModuleScreenNoResult(message: $message)';
}

class ModuleScreenFailed extends ModuleScreenState {
  final String errorMsg;
  ModuleScreenFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModuleScreenFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'ContentScreenFailed(errorMsg: $errorMsg)';
}
