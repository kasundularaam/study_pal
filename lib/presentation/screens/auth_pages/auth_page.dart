import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/constants/shared_prefs_keys.dart';
import 'package:study_pal/core/my_enums.dart';
import 'package:study_pal/core/screen_arguments/content_screen_args.dart';
import 'package:study_pal/logic/cubit/auth_cubit/auth_cubit.dart';
import 'package:study_pal/logic/cubit/auth_nav_cubit/authscreen_nav_cubit.dart';
import 'package:study_pal/presentation/router/app_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).checkUserStatus();
  }

  Future<void> goToHome() async {
    await Future.delayed(Duration(milliseconds: 500));
    Navigator.popAndPushNamed(context, AppRouter.home);
  }

  Future<void> navigateToLogin() async {
    await Future.delayed(Duration(milliseconds: 500));
    BlocProvider.of<AuthscreenNavCubit>(context)
        .authNavigate(authNav: AuthNav.toLogin);
  }

  Future<void> checkSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isOnWorking = prefs.getBool(SharedPrefsKeys.isOnWorkingKey);
    if (isOnWorking != null) {
      if (isOnWorking) {
        Navigator.popAndPushNamed(
          context,
          AppRouter.workingScreen,
          arguments: ContentScreenArgs(
            contentId: prefs.getString(SharedPrefsKeys.contentIdKey) ?? "",
            contentName: prefs.getString(SharedPrefsKeys.contentNameKey) ?? "",
            subjectName: prefs.getString(SharedPrefsKeys.subjectNameKey) ?? "",
            subjectId: prefs.getString(SharedPrefsKeys.subjectIdKey) ?? "",
            moduleName: prefs.getString(SharedPrefsKeys.moduleNameKey) ?? "",
            moduleId: prefs.getString(SharedPrefsKeys.moduleIdKey) ?? "",
          ),
        );
      } else {
        goToHome();
      }
    } else {
      goToHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 3.h,
        ),
        Image.asset(
          "assets/images/autht.png",
        ),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthFailed) {
              return buildFailedState(state.errorMsg);
            } else if (state is AuthCheckUserStatus) {
              if (state.userStatus) {
                checkSP();
              } else {
                navigateToLogin();
              }
              return Center(
                child: Text(
                  state.statusMsg,
                  style: TextStyle(
                    color: MyColors.textColorDark,
                    fontSize: 12.sp,
                  ),
                ),
              );
            } else if (state is AuthLoading) {
              return Center(
                child: Text(
                  state.loadingMsg,
                  style: TextStyle(
                    color: MyColors.textColorDark,
                    fontSize: 12.sp,
                  ),
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
        SizedBox(
          height: 3.h,
        ),
      ],
    );
  }

  Widget buildFailedState(String errorMsg) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          errorMsg,
          style: TextStyle(
            color: MyColors.textColorDark,
            fontSize: 12,
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        TextButton(
          onPressed: () =>
              BlocProvider.of<AuthCubit>(context).checkUserStatus(),
          child: Text(
            "Try Again",
            style: TextStyle(
              color: MyColors.titleClr,
              fontSize: 16.sp,
            ),
          ),
        ),
      ]),
    );
  }
}
