part of 'home_nav_cubit.dart';

@immutable
abstract class HomeNavState {}

class HomeNavInitial extends HomeNavState {}

class HomeScreenNavigate extends HomeNavState {
  final HomeNav homeNav;
  HomeScreenNavigate({
    required this.homeNav,
  });
}
