part of 'countdown_cubit.dart';

@immutable
abstract class CountdownState {}

class CountdownInitial extends CountdownState {}

class CountdownRunning extends CountdownState {
  final String countdown;
  CountdownRunning({
    required this.countdown,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountdownRunning && other.countdown == countdown;
  }

  @override
  int get hashCode => countdown.hashCode;

  @override
  String toString() => 'CountdownRunning(countdown: $countdown)';
}

class CountdownEnded extends CountdownState {}
