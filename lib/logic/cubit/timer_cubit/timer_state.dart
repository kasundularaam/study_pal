part of 'timer_cubit.dart';

@immutable
abstract class TimerState {}

class TimerInitial extends TimerState {
  final String initCounter;
  TimerInitial({
    required this.initCounter,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimerInitial && other.initCounter == initCounter;
  }

  @override
  int get hashCode => initCounter.hashCode;

  @override
  String toString() => 'TimerInitial(initCounter: $initCounter)';
}

class TimerStarted extends TimerState {
  final String startedCounter;
  TimerStarted({
    required this.startedCounter,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimerStarted && other.startedCounter == startedCounter;
  }

  @override
  int get hashCode => startedCounter.hashCode;

  @override
  String toString() => 'TimerStarted(startedCounter: $startedCounter)';
}

class TimerRunning extends TimerState {
  final String timeCounter;
  TimerRunning({
    required this.timeCounter,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimerRunning && other.timeCounter == timeCounter;
  }

  @override
  int get hashCode => timeCounter.hashCode;

  @override
  String toString() => 'TimerRunning(timeCounter: $timeCounter)';
}

class TimerEnded extends TimerState {
  final EndTabArgs args;
  TimerEnded({
    required this.args,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimerEnded && other.args == args;
  }

  @override
  int get hashCode => args.hashCode;

  @override
  String toString() => 'TimerEnded(args: $args)';
}
