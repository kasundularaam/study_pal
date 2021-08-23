part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}

class SettingLoading extends SettingState {}

class SettingLoaded extends SettingState {
  final FireUser fireUser;
  final List<Subject> fireSubjects;
  final List<Subject> subjects;
  SettingLoaded({
    required this.fireUser,
    required this.fireSubjects,
    required this.subjects,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingLoaded &&
        other.fireUser == fireUser &&
        listEquals(other.fireSubjects, fireSubjects) &&
        listEquals(other.subjects, subjects);
  }

  @override
  int get hashCode =>
      fireUser.hashCode ^ fireSubjects.hashCode ^ subjects.hashCode;

  @override
  String toString() =>
      'SettingLoaded(fireUser: $fireUser, fireSubjects: $fireSubjects, subjects: $subjects)';
}

class SettingFailed extends SettingState {
  final String errorMsg;
  SettingFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'SettingFailed(errorMsg: $errorMsg)';
}
