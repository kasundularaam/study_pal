part of 'set_countdown_cubit.dart';

@immutable
abstract class SetCountdownState {}

class SetCountdownInitial extends SetCountdownState {}

class SetCountdownLoading extends SetCountdownState {}

class SetCountdownSucceed extends SetCountdownState {}

class SetCountdownFaild extends SetCountdownState {
  final String errorMsg;
  SetCountdownFaild({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SetCountdownFaild && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'SetCountdownFaild(errorMsg: $errorMsg)';
}
