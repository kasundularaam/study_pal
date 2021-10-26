part of 'qs_item_cubit.dart';

@immutable
abstract class QsItemState {}

class QsItemInitial extends QsItemState {}

class QsItemLoading extends QsItemState {}

class QsItemLoaded extends QsItemState {
  final int all;
  final int done;
  final int correct;
  final Color color;
  final int precentage;
  QsItemLoaded({
    required this.all,
    required this.done,
    required this.correct,
    required this.color,
    required this.precentage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QsItemLoaded &&
        other.all == all &&
        other.done == done &&
        other.correct == correct &&
        other.color == color &&
        other.precentage == precentage;
  }

  @override
  int get hashCode {
    return all.hashCode ^
        done.hashCode ^
        correct.hashCode ^
        color.hashCode ^
        precentage.hashCode;
  }

  @override
  String toString() {
    return 'QsItemLoaded(all: $all, done: $done, correct: $correct, color: $color, precentage: $precentage)';
  }
}

class QsItemFailed extends QsItemState {}
