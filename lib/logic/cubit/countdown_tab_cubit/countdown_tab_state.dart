part of 'countdown_tab_cubit.dart';

@immutable
abstract class CountdownTabState {}

class CountdownTabInitial extends CountdownTabState {}

class CountdownTabLoading extends CountdownTabState {}

class CountdownTabLoaded extends CountdownTabState {
  final List<Countdown> countdowns;
  CountdownTabLoaded({
    required this.countdowns,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountdownTabLoaded &&
        listEquals(other.countdowns, countdowns);
  }

  @override
  int get hashCode => countdowns.hashCode;

  @override
  String toString() => 'CountdownTabLoaded(countdowns: $countdowns)';
}

class CountdownTabFailed extends CountdownTabState {
  final String errorMsg;
  CountdownTabFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountdownTabFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'CountdownTabFailed(errorMsg: $errorMsg)';
}

class CountdownTabNew extends CountdownTabState {}

class CountdownTabEdit extends CountdownTabState {
  final Countdown countdown;

  CountdownTabEdit({
    required this.countdown,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountdownTabEdit && other.countdown == countdown;
  }

  @override
  int get hashCode => countdown.hashCode;

  @override
  String toString() => 'CountdownTabEdit(countdown: $countdown)';
}

class CountdownTabNoResults extends CountdownTabState {}
