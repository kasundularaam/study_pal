part of 'add_work_details_cubit.dart';

@immutable
abstract class AddWorkDetailsState {}

class AddWorkDetailsInitial extends AddWorkDetailsState {}

class AddWorkDetailsLoading extends AddWorkDetailsState {}

class AddWorkDetailsSucceed extends AddWorkDetailsState {
  final bool isCompleted;
  AddWorkDetailsSucceed({
    required this.isCompleted,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddWorkDetailsSucceed && other.isCompleted == isCompleted;
  }

  @override
  int get hashCode => isCompleted.hashCode;

  @override
  String toString() => 'AddWorkDetailsSucceed(isCompleted: $isCompleted)';
}

class AddWorkDetailsFailed extends AddWorkDetailsState {
  final String errorMsg;
  AddWorkDetailsFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddWorkDetailsFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'AddWorkDetailsFailed(errorMsg: $errorMsg)';
}
