part of 'profile_top_card_cubit.dart';

@immutable
abstract class ProfileTopCardState {}

class ProfileTopCardInitial extends ProfileTopCardState {}

class ProfileTopCardLoading extends ProfileTopCardState {}

class ProfileTopCardLoaded extends ProfileTopCardState {
  final FireUser fireUser;
  ProfileTopCardLoaded({
    required this.fireUser,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfileTopCardLoaded && other.fireUser == fireUser;
  }

  @override
  int get hashCode => fireUser.hashCode;

  @override
  String toString() => 'ProfileTopCardLoaded(fireUser: $fireUser)';
}

class ProfileTopCardFailed extends ProfileTopCardState {
  final String errorMsg;
  ProfileTopCardFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfileTopCardFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'ProfileTopCardFailed(errorMsg: $errorMsg)';
}
