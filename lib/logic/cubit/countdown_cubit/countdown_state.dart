part of 'countdown_cubit.dart';

@immutable
abstract class CountdownState {}

class CountdownInitial extends CountdownState {}

class CountdownRunning extends CountdownState {
  final String daysStr;
  final String hoursStr;
  final String minutesStr;
  final String secondsStr;
  CountdownRunning({
    required this.daysStr,
    required this.hoursStr,
    required this.minutesStr,
    required this.secondsStr,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountdownRunning &&
        other.daysStr == daysStr &&
        other.hoursStr == hoursStr &&
        other.minutesStr == minutesStr &&
        other.secondsStr == secondsStr;
  }

  @override
  int get hashCode {
    return daysStr.hashCode ^
        hoursStr.hashCode ^
        minutesStr.hashCode ^
        secondsStr.hashCode;
  }

  @override
  String toString() {
    return 'CountdownRunning(daysStr: $daysStr, hoursStr: $hoursStr, minutesStr: $minutesStr, secondsStr: $secondsStr)';
  }
}

class CountdownEnded extends CountdownState {}
