part of 'working_cubit.dart';

@immutable
abstract class WorkingState {}

class WorkingInitial extends WorkingState {}

class WorkingEnded extends WorkingState {
  final EndTabArgs args;
  WorkingEnded({
    required this.args,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WorkingEnded && other.args == args;
  }

  @override
  int get hashCode => args.hashCode;

  @override
  String toString() => 'WorkingEnded(args: $args)';
}

class WorkingOnNow extends WorkingState {
  final String workingContentName;
  WorkingOnNow({
    required this.workingContentName,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WorkingOnNow &&
        other.workingContentName == workingContentName;
  }

  @override
  int get hashCode => workingContentName.hashCode;

  @override
  String toString() => 'WorkingOnNow(workingContentName: $workingContentName)';
}

class WorkingContentCompleted extends WorkingState {
  final String contentName;
  WorkingContentCompleted({
    required this.contentName,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WorkingContentCompleted && other.contentName == contentName;
  }

  @override
  int get hashCode => contentName.hashCode;

  @override
  String toString() => 'WorkingContentCompleted(contentName: $contentName)';
}
