import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/core/my_enums.dart';

part 'home_nav_state.dart';

class HomeNavCubit extends Cubit<HomeNavState> {
  HomeNavCubit() : super(HomeNavInitial());

  void homeNavigate({required HomeNav homeNav}) {
    emit(HomeScreenNavigate(homeNav: homeNav));
  }
}
