import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/logic/cubit/logout_cubit/logout_cubit.dart';
import 'package:study_pal/logic/cubit/profile_top_card_cubit/profile_top_card_cubit.dart';
import 'package:study_pal/logic/cubit/sub_prog_card_cubit/sub_prog_card_cubit.dart';
import 'package:study_pal/logic/cubit/today_worls_cubit/today_works_cubit.dart';
import 'package:study_pal/logic/cubit/work_card_list_cubit/work_card_list_cubit.dart';
import 'package:study_pal/presentation/router/app_router.dart';
import 'package:study_pal/presentation/screens/widgets/profile_top_card.dart';
import 'package:study_pal/presentation/screens/widgets/sub_prog_card.dart';
import 'package:study_pal/presentation/screens/widgets/today_worked_details.dart';
import 'package:study_pal/presentation/screens/widgets/work_card_list.dart';
import 'package:study_pal/presentation/templates/home_tabs_tmpl.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return HomeTabsTmpl(
      title: "Profile",
      content: Container(
        child: ListView(physics: BouncingScrollPhysics(), children: [
          SizedBox(height: 2.h),
          Row(
            children: [
              SizedBox(width: 5.w),
              Text(
                "Profile",
                style: TextStyle(
                    color: MyColors.titleClr,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 5.w,
              ),
              BlocProvider(
                create: (context) => ProfileTopCardCubit(),
                child: ProfileTopCard(),
              ),
            ],
          ),
          ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            children: [
              Container(
                child: BlocProvider(
                  create: (context) => TodayWorksCubit(),
                  child: TodayWorkedDetails(),
                ),
              ),
              BlocProvider(
                create: (context) => SubProgCardCubit(),
                child: SubProgCard(),
              ),
              Divider(
                thickness: 0.2.w,
                color: MyColors.textColorDark,
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                child: Text(
                  "Your activities",
                  style: TextStyle(
                    color: MyColors.textColorDark,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              BlocProvider(
                create: (context) => WorkCardListCubit(),
                child: WorkCardList(),
              ),
            ],
          ),
        ]),
      ),
      action: BlocConsumer<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSucceed) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRouter.authScreen, (Route<dynamic> route) => false);
          } else if (state is LogoutFailed) {
            SnackBar snackBar = SnackBar(content: Text(state.errorMsg));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is LogoutLoading) {
            return CircularProgressIndicator(
              color: MyColors.progressColor,
            );
          } else if (state is LogoutSucceed) {
            return Icon(
              Icons.check_rounded,
              size: 14.sp,
              color: MyColors.textColorDark,
            );
          } else {
            return GestureDetector(
              onTap: () => BlocProvider.of<LogoutCubit>(context).logOut(),
              child: Icon(
                Icons.logout_rounded,
                size: 14.sp,
                color: MyColors.textColorDark,
              ),
            );
          }
        },
      ),
    );
  }
}
