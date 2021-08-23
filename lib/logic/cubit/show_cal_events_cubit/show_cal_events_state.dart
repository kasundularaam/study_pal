part of 'show_cal_events_cubit.dart';

@immutable
abstract class ShowCalEventsState {}

class ShowCalEventsInitial extends ShowCalEventsState {}

class ShowCalEventsLoading extends ShowCalEventsState {}

class ShowCalEventsLoaded extends ShowCalEventsState {
  final List<CalEvent> calEvents;
  ShowCalEventsLoaded({
    required this.calEvents,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShowCalEventsLoaded &&
        listEquals(other.calEvents, calEvents);
  }

  @override
  int get hashCode => calEvents.hashCode;

  @override
  String toString() => 'ShowCalEventsLoaded(calEvents: $calEvents)';
}

class ShowCalEventsNoResult extends ShowCalEventsState {
  final String message;
  ShowCalEventsNoResult({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShowCalEventsNoResult && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'ShowCalEventsNoResult(message: $message)';
}

class ShowCalEventsFailed extends ShowCalEventsState {
  final String errorMsg;
  ShowCalEventsFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShowCalEventsFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'ShowCalEventsFailed(errorMsg: $errorMsg)';
}
