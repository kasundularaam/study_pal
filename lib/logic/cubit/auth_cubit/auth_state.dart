part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  final String loadingMsg;
  AuthLoading({
    required this.loadingMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthLoading && other.loadingMsg == loadingMsg;
  }

  @override
  int get hashCode => loadingMsg.hashCode;
}

class AuthSucceed extends AuthState {}

class AuthSubjectLoading extends AuthState {
  final String loadingMst;
  AuthSubjectLoading({
    required this.loadingMst,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthSubjectLoading && other.loadingMst == loadingMst;
  }

  @override
  int get hashCode => loadingMst.hashCode;

  @override
  String toString() => 'AuthSubjectLoading(loadingMst: $loadingMst)';
}

class AuthSubjectLoaded extends AuthState {
  final List<Subject> subjectList;
  AuthSubjectLoaded({
    required this.subjectList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthSubjectLoaded &&
        listEquals(other.subjectList, subjectList);
  }

  @override
  int get hashCode => subjectList.hashCode;

  @override
  String toString() => 'AuthSubjectLoaded(subjectList: $subjectList)';
}

class AuthCheckUserStatus extends AuthState {
  final bool userStatus;
  final String statusMsg;
  AuthCheckUserStatus({
    required this.userStatus,
    required this.statusMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthCheckUserStatus &&
        other.userStatus == userStatus &&
        other.statusMsg == statusMsg;
  }

  @override
  int get hashCode => userStatus.hashCode ^ statusMsg.hashCode;
}

class AuthFailed extends AuthState {
  final String errorMsg;
  AuthFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;
}

class AuthSubjectFailed extends AuthState {
  final String errorMsg;
  AuthSubjectFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthSubjectFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'AuthSubjectFailed(errorMsg: $errorMsg)';
}
