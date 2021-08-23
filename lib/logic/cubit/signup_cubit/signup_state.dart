part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {
  final String loadingMsg;
  SignupLoading({
    required this.loadingMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignupLoading && other.loadingMsg == loadingMsg;
  }

  @override
  int get hashCode => loadingMsg.hashCode;

  @override
  String toString() => 'SignupLoading(loadingMsg: $loadingMsg)';
}

class SignupSucceed extends SignupState {}

class SignupFailed extends SignupState {
  final String errorMsg;
  SignupFailed({
    required this.errorMsg,
  });

  @override
  String toString() => 'SignupFailed(errorMsg: $errorMsg)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignupFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;
}

class SignupWithInvalidValue extends SignupState {
  final String errorMsg;
  SignupWithInvalidValue({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignupWithInvalidValue && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'SignupWithInvalidValue(errorMsg: $errorMsg)';
}
