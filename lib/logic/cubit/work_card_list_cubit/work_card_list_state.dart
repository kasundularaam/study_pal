part of 'work_card_list_cubit.dart';

@immutable
abstract class WorkCardListState {}

class WorkCardListInitial extends WorkCardListState {}

class WorkCardListLoading extends WorkCardListState {}

class WorkCardListLoaded extends WorkCardListState {
  final List<FireContent> fireContents;
  final String profileImage;
  WorkCardListLoaded({
    required this.fireContents,
    required this.profileImage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WorkCardListLoaded &&
        listEquals(other.fireContents, fireContents) &&
        other.profileImage == profileImage;
  }

  @override
  int get hashCode => fireContents.hashCode ^ profileImage.hashCode;

  @override
  String toString() =>
      'WorkCardListLoaded(fireContents: $fireContents, profileImage: $profileImage)';
}

class WorkCardListFailed extends WorkCardListState {
  final String errorMsg;
  WorkCardListFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WorkCardListFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'WorkCardListFailed(errorMsg: $errorMsg)';
}
