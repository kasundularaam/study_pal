part of 'logout_cubit.dart';

@immutable
abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {
  final String loadingMsg;
  LogoutLoading({
    required this.loadingMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LogoutLoading && other.loadingMsg == loadingMsg;
  }

  @override
  int get hashCode => loadingMsg.hashCode;

  @override
  String toString() => 'LogoutLoading(loadingMsg: $loadingMsg)';
}

class LogoutSucceed extends LogoutState {}

class LogoutFailed extends LogoutState {
  final String errorMsg;
  LogoutFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LogoutFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'LogoutFailed(errorMsg: $errorMsg)';
}
