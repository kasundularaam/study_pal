part of 'change_password_cubit.dart';

@immutable
abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSucceed extends ChangePasswordState {
  final String message;
  ChangePasswordSucceed({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChangePasswordSucceed && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'ChangePasswordSucceed(message: $message)';
}

class ChangePasswordFailed extends ChangePasswordState {
  final String errorMsg;
  ChangePasswordFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChangePasswordFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'ChangePasswordFailed(errorMsg: $errorMsg)';
}
