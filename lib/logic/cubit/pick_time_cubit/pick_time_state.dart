part of 'pick_time_cubit.dart';

@immutable
abstract class PickTimeState {}

class PickTimeInitial extends PickTimeState {}

class PickTimePicked extends PickTimeState {
  final TimeOfDay pickedTime;
  final String pickedTimeStr;
  PickTimePicked({
    required this.pickedTime,
    required this.pickedTimeStr,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PickTimePicked &&
        other.pickedTime == pickedTime &&
        other.pickedTimeStr == pickedTimeStr;
  }

  @override
  int get hashCode => pickedTime.hashCode ^ pickedTimeStr.hashCode;

  @override
  String toString() =>
      'PickTimePicked(pickedTime: $pickedTime, pickedTimeStr: $pickedTimeStr)';
}
