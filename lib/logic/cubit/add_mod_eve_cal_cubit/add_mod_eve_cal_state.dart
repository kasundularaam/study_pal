part of 'add_mod_eve_cal_cubit.dart';

@immutable
abstract class AddModEveCalState {}

class AddModEveCalInitial extends AddModEveCalState {}

class AddModEveCalLoading extends AddModEveCalState {}

class AddModEveCalSucceed extends AddModEveCalState {}

class AddModEveCalFailed extends AddModEveCalState {
  final String errorMsg;
  AddModEveCalFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddModEveCalFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'AddEventsForMFailed(errorMsg: $errorMsg)';
}
