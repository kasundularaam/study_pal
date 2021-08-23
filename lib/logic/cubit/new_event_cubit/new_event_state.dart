part of 'new_event_cubit.dart';

@immutable
abstract class NewEventState {}

class NewEventInitial extends NewEventState {}

class NewEventLoading extends NewEventState {}

class NewEventSucceed extends NewEventState {}

class NewEventFailed extends NewEventState {
  final String errorMsg;
  NewEventFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewEventFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'NewEventFailed(errorMsg: $errorMsg)';
}
