part of 'pick_date_cubit.dart';

@immutable
abstract class PickDateState {}

class PickDateInitial extends PickDateState {}

class PickDatePicked extends PickDateState {
  final DateTime pickedDate;
  final String pickedDateStr;
  PickDatePicked({
    required this.pickedDate,
    required this.pickedDateStr,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PickDatePicked &&
        other.pickedDate == pickedDate &&
        other.pickedDateStr == pickedDateStr;
  }

  @override
  int get hashCode => pickedDate.hashCode ^ pickedDateStr.hashCode;

  @override
  String toString() =>
      'PickDatePicked(pickedDate: $pickedDate, pickedDateStr: $pickedDateStr)';
}
