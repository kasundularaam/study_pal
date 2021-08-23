part of 'sub_prog_card_cubit.dart';

@immutable
abstract class SubProgCardState {}

class SubProgCardInitial extends SubProgCardState {}

class SubProgCardLoading extends SubProgCardState {}

class SubProgCardLoaded extends SubProgCardState {
  final List<Subject> subjectList;
  SubProgCardLoaded({
    required this.subjectList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubProgCardLoaded &&
        listEquals(other.subjectList, subjectList);
  }

  @override
  int get hashCode => subjectList.hashCode;

  @override
  String toString() => 'SubProgCardLoaded(subjectList: $subjectList)';
}

class SubProgCardFailed extends SubProgCardState {
  final String errorMsg;
  SubProgCardFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubProgCardFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'SubProgCardFailed(errorMsg: $errorMsg)';
}
