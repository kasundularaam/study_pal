import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/my_enums.dart';
import 'package:study_pal/logic/cubit/home_nav_cubit/home_nav_cubit.dart';
import 'package:study_pal/logic/cubit/home_tab_cubit/home_tab_cubit.dart';
import 'package:study_pal/logic/cubit/logout_cubit/logout_cubit.dart';
import 'package:study_pal/presentation/router/app_router.dart';
import 'package:study_pal/presentation/screens/home_tabs/countdown_tab.dart';
import 'package:study_pal/presentation/screens/home_tabs/events_tab.dart';
import 'package:study_pal/presentation/screens/home_tabs/home_tab.dart';
import 'package:study_pal/presentation/screens/home_tabs/profile_tab.dart';

import 'widgets/bottom_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeTabCubit _homeTabCubit = HomeTabCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeNavCubit(),
      child: Scaffold(
        backgroundColor: MyColors.primaryColor,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: (constraints.maxHeight * 90) / 100,
                    child: BlocBuilder<HomeNavCubit, HomeNavState>(
                        builder: (context, state) {
                      if (state is HomeNavInitial) {
                        return BlocProvider.value(
                          value: _homeTabCubit,
                          child: HomeTab(),
                        );
                      } else if (state is HomeScreenNavigate) {
                        if (state.homeNav == HomeNav.toHome) {
                          return BlocProvider.value(
                            value: _homeTabCubit,
                            child: HomeTab(),
                          );
                        } else if (state.homeNav == HomeNav.toProfile) {
                          return BlocProvider(
                            create: (context) => LogoutCubit(),
                            child: ProfileTab(),
                          );
                        } else if (state.homeNav == HomeNav.toEvents) {
                          return BlocProvider.value(
                            value: AppRouter.showCalEventsCubit,
                            child: EventsTab(),
                          );
                        } else if (state.homeNav == HomeNav.toCountDown) {
                          return BlocProvider.value(
                            value: AppRouter.countdownTabCubit,
                            child: CountDownTab(),
                          );
                        } else {
                          return BlocProvider.value(
                            value: _homeTabCubit,
                            child: HomeTab(),
                          );
                        }
                      } else {
                        return BlocProvider.value(
                          value: _homeTabCubit,
                          child: HomeTab(),
                        );
                      }
                    }),
                  ),
                  BottomTab(
                    height: (constraints.maxHeight * 9) / 100,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
