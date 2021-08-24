import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/my_enums.dart';
import 'package:study_pal/logic/cubit/home_nav_cubit/home_nav_cubit.dart';

class BottomTab extends StatefulWidget {
  final double height;
  const BottomTab({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: 100.w,
      child: BlocBuilder<HomeNavCubit, HomeNavState>(
        builder: (context, state) {
          if (state is HomeNavInitial) {
            return buildInitState();
          } else if (state is HomeScreenNavigate) {
            if (state.homeNav == HomeNav.toHome) {
              return buildNavState(MyColors.navBtnSelctdClr, MyColors.navBtnClr,
                  MyColors.navBtnClr, MyColors.navBtnClr);
            } else if (state.homeNav == HomeNav.toProfile) {
              return buildNavState(MyColors.navBtnClr, MyColors.navBtnClr,
                  MyColors.navBtnClr, MyColors.navBtnSelctdClr);
            } else if (state.homeNav == HomeNav.toEvents) {
              return buildNavState(MyColors.navBtnClr, MyColors.navBtnSelctdClr,
                  MyColors.navBtnClr, MyColors.navBtnClr);
            } else if (state.homeNav == HomeNav.toCountDown) {
              return buildNavState(MyColors.navBtnClr, MyColors.navBtnClr,
                  MyColors.navBtnSelctdClr, MyColors.navBtnClr);
            } else {
              return buildInitState();
            }
          } else {
            return buildInitState();
          }
        },
      ),
    );
  }

  Widget buildInitState() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BottomTabButton(
          color: MyColors.navBtnSelctdClr,
          btnIcon: Icons.home_rounded,
          onPressed: () => BlocProvider.of<HomeNavCubit>(context)
              .homeNavigate(homeNav: HomeNav.toHome),
        ),
        BottomTabButton(
          color: MyColors.navBtnClr,
          btnIcon: Icons.event_rounded,
          onPressed: () => BlocProvider.of<HomeNavCubit>(context)
              .homeNavigate(homeNav: HomeNav.toEvents),
        ),
        BottomTabButton(
          color: MyColors.navBtnClr,
          btnIcon: Icons.alarm_rounded,
          onPressed: () => BlocProvider.of<HomeNavCubit>(context)
              .homeNavigate(homeNav: HomeNav.toCountDown),
        ),
        BottomTabButton(
          color: MyColors.navBtnClr,
          btnIcon: Icons.person_rounded,
          onPressed: () => BlocProvider.of<HomeNavCubit>(context)
              .homeNavigate(homeNav: HomeNav.toProfile),
        ),
      ],
    );
  }

  Widget buildNavState(Color hColor, Color cColor, Color aColor, Color pColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BottomTabButton(
          color: hColor,
          btnIcon: Icons.home_rounded,
          onPressed: () => BlocProvider.of<HomeNavCubit>(context)
              .homeNavigate(homeNav: HomeNav.toHome),
        ),
        BottomTabButton(
          color: cColor,
          btnIcon: Icons.event_rounded,
          onPressed: () => BlocProvider.of<HomeNavCubit>(context)
              .homeNavigate(homeNav: HomeNav.toEvents),
        ),
        BottomTabButton(
          color: aColor,
          btnIcon: Icons.alarm_rounded,
          onPressed: () => BlocProvider.of<HomeNavCubit>(context)
              .homeNavigate(homeNav: HomeNav.toCountDown),
        ),
        BottomTabButton(
          color: pColor,
          btnIcon: Icons.person_rounded,
          onPressed: () => BlocProvider.of<HomeNavCubit>(context)
              .homeNavigate(homeNav: HomeNav.toProfile),
        ),
      ],
    );
  }
}

class BottomTabButton extends StatelessWidget {
  final Color color;
  final IconData btnIcon;
  final Function onPressed;
  const BottomTabButton({
    Key? key,
    required this.color,
    required this.btnIcon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        child: Icon(
          btnIcon,
          size: 30.sp,
          color: color,
        ),
      ),
    );
  }
}
