part of 'home_sub_list_cubit.dart';

@immutable
abstract class HomeSubListState {}

class HomeSubListInitial extends HomeSubListState {}

class HomeSubListLoading extends HomeSubListState {
  final String loadingMsg;
  HomeSubListLoading({
    required this.loadingMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeSubListLoading && other.loadingMsg == loadingMsg;
  }

  @override
  int get hashCode => loadingMsg.hashCode;

  @override
  String toString() => 'HomeSubListLoading(loadingMsg: $loadingMsg)';
}

class HomeSubListLoaded extends HomeSubListState {
  final HomeSubCard homeSubCard;
  HomeSubListLoaded({
    required this.homeSubCard,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeSubListLoaded && other.homeSubCard == homeSubCard;
  }

  @override
  int get hashCode => homeSubCard.hashCode;

  @override
  String toString() => 'HomeSubListLoaded(homeSubCard: $homeSubCard)';
}

class HomeSubListFailed extends HomeSubListState {
  final String errorMsg;
  HomeSubListFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeSubListFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'HomeSubListFailed(errorMsg: $errorMsg)';
}
