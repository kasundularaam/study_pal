part of 'show_events_cubit.dart';

@immutable
abstract class ShowEventsState {}

class ShowEventsInitial extends ShowEventsState {}

class ShowEventsLoading extends ShowEventsState {}

class ShowEventsLoaded extends ShowEventsState {
  final List<CalEvent> events;
  ShowEventsLoaded({
    required this.events,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShowEventsLoaded && listEquals(other.events, events);
  }

  @override
  int get hashCode => events.hashCode;

  @override
  String toString() => 'ShowEventsLoaded(events: $events)';
}

class ShowEventsFailed extends ShowEventsState {
  final String errorMsg;
  ShowEventsFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShowEventsFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'ShowEventsFailed(errorMsg: $errorMsg)';
}
