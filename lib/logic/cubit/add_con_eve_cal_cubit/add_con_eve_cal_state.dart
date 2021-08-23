part of 'add_con_eve_cal_cubit.dart';

@immutable
abstract class AddConEventToCalState {}

class AddConEventToCalInitial extends AddConEventToCalState {}

class AddConEventToCalLoading extends AddConEventToCalState {}

class AddConEventToCalSucceed extends AddConEventToCalState {}

class AddConEventToCalFailed extends AddConEventToCalState {
  final String errorMsg;
  AddConEventToCalFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddConEventToCalFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'AddEventCalFailed(errorMsg: $errorMsg)';
}
