part of 'subject_card_cubit.dart';

@immutable
abstract class SubjectCardState {}

class SubjectCardInitial extends SubjectCardState {}

class SubjectCardLoading extends SubjectCardState {}

class SubjectCardLoaded extends SubjectCardState {
  final int moduleCount;
  final int completedModules;
  final int contentCount;
  final int completedContents;
  final int quizCount;
  SubjectCardLoaded({
    required this.moduleCount,
    required this.completedModules,
    required this.contentCount,
    required this.completedContents,
    required this.quizCount,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubjectCardLoaded &&
        other.moduleCount == moduleCount &&
        other.completedModules == completedModules &&
        other.contentCount == contentCount &&
        other.completedContents == completedContents &&
        other.quizCount == quizCount;
  }

  @override
  int get hashCode {
    return moduleCount.hashCode ^
        completedModules.hashCode ^
        contentCount.hashCode ^
        completedContents.hashCode ^
        quizCount.hashCode;
  }

  @override
  String toString() {
    return 'SubjectCardLoaded(moduleCount: $moduleCount, completedModules: $completedModules, contentCount: $contentCount, completedContents: $completedContents, quizCount: $quizCount)';
  }
}

class SubjectCardFailed extends SubjectCardState {
  final String errorMsg;
  SubjectCardFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubjectCardFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'SubjectCardFailed(errorMsg: $errorMsg)';
}
