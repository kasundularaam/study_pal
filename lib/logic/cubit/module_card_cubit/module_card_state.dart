part of 'module_card_cubit.dart';

@immutable
abstract class ModuleCardState {}

class ModuleCardInitial extends ModuleCardState {}

class ModuleCardLoading extends ModuleCardState {}

class ModuleCardLoaded extends ModuleCardState {
  final int contentCount;
  final int quizCount;
  final Color color;
  ModuleCardLoaded({
    required this.contentCount,
    required this.quizCount,
    required this.color,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModuleCardLoaded &&
        other.contentCount == contentCount &&
        other.quizCount == quizCount &&
        other.color == color;
  }

  @override
  int get hashCode =>
      contentCount.hashCode ^ quizCount.hashCode ^ color.hashCode;

  @override
  String toString() =>
      'ModuleCardLoaded(contentCount: $contentCount, quizCount: $quizCount, color: $color)';
}

class ModuleCardFailed extends ModuleCardState {
  final String errorMsg;
  ModuleCardFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModuleCardFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'ModuleCardFailed(errorMsg: $errorMsg)';
}
