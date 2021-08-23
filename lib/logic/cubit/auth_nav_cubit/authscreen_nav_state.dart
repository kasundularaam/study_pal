part of 'authscreen_nav_cubit.dart';

@immutable
abstract class AuthscreenNavState {}

class AuthscreenNavInitial extends AuthscreenNavState {}

class AuthscreenNavigate extends AuthscreenNavState {
  final AuthNav authNav;
  AuthscreenNavigate({
    required this.authNav,
  });
}
