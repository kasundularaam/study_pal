part of 'subject_screen_cubit.dart';

@immutable
abstract class SubjectScreenState {}

class SubjectScreenInitial extends SubjectScreenState {}

class SubjectScreenLoading extends SubjectScreenState {}

class SubjectScreenLoaded extends SubjectScreenState {
  final List<Module> moduleList;
  SubjectScreenLoaded({
    required this.moduleList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubjectScreenLoaded &&
        listEquals(other.moduleList, moduleList);
  }

  @override
  int get hashCode => moduleList.hashCode;

  @override
  String toString() => 'ModuleScreenLoaded(moduleList: $moduleList)';
}

class SubjectScreenFailed extends SubjectScreenState {
  final String errorMsg;
  SubjectScreenFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubjectScreenFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'ModuleScreenFailed(errorMsg: $errorMsg)';
}

class SubjectScreenNoResult extends SubjectScreenState {
  final String message;
  SubjectScreenNoResult({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubjectScreenNoResult && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'ModuleScreenNoResult(message: $message)';
}
