part of 'edit_name_cubit.dart';

@immutable
abstract class EditNameState {}

class EditNameInitial extends EditNameState {}

class EditNameLoading extends EditNameState {}

class EditNameSucceed extends EditNameState {
  final String message;
  EditNameSucceed({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EditNameSucceed && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'EditNameSucceed(message: $message)';
}

class EditNameFailed extends EditNameState {
  final String errorMsg;
  EditNameFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EditNameFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'EditNameFailed(errorMsg: $errorMsg)';
}
