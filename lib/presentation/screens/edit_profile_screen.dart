import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/logic/cubit/change_password_cubit/change_password_cubit.dart';
import 'package:study_pal/logic/cubit/edit_name_cubit/edit_name_cubit.dart';
import 'package:study_pal/logic/cubit/logout_cubit/logout_cubit.dart';
import 'package:study_pal/logic/cubit/settings_cubit/setting_cubit.dart';
import 'package:study_pal/presentation/router/app_router.dart';
import 'package:study_pal/presentation/screens/widgets/change_password_card.dart';
import 'package:study_pal/presentation/screens/widgets/change_subjects_card.dart';
import 'package:study_pal/presentation/screens/widgets/edit_name_card.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SettingCubit>(context).loadProfileSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.screenBgDarkColor,
      body: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Container(
                height: (constraints.maxHeight * 10) / 100,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: EdgeInsets.all(5.w),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: MyColors.textColorLight,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Edit profile",
                        style: TextStyle(
                            color: MyColors.textColorLight,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: (constraints.maxHeight * 90) / 100,
                decoration: BoxDecoration(
                  color: MyColors.screenBgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.w),
                    topRight: Radius.circular(8.w),
                  ),
                ),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    BlocBuilder<SettingCubit, SettingState>(
                      builder: (context, state) {
                        if (state is SettingInitial) {
                          return Center(child: Text("Initial State"));
                        } else if (state is SettingLoading) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: MyColors.progressColor,
                          ));
                        } else if (state is SettingLoaded) {
                          return Column(
                            children: [
                              BlocProvider(
                                create: (context) => EditNameCubit(),
                                child: EditNameCard(
                                    fireUser: state.fireUser,
                                    onSucceed: (message) {
                                      SnackBar succeedSnack =
                                          SnackBar(content: Text(message));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(succeedSnack);
                                    },
                                    onError: (error) {
                                      SnackBar errorSnack =
                                          SnackBar(content: Text(error));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(errorSnack);
                                    }),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              BlocProvider(
                                create: (context) => ChangePasswordCubit(),
                                child: ChangePasswordCard(onSucceed: (message) {
                                  SnackBar succeedSnack =
                                      SnackBar(content: Text(message));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(succeedSnack);
                                }, onFailed: (errorMsg) {
                                  SnackBar errorSnack =
                                      SnackBar(content: Text(errorMsg));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(errorSnack);
                                }),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              ChangeSubjectsCard(
                                screenContext: context,
                                fireSubjects: state.fireSubjects,
                                subjects: state.subjects,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              BlocProvider(
                                create: (context) => LogoutCubit(),
                                child: Center(
                                  child: BlocConsumer<LogoutCubit, LogoutState>(
                                    listener: (context, state) {
                                      if (state is LogoutSucceed) {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            AppRouter.authScreen,
                                            (Route<dynamic> route) => false);
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is LogoutInitial) {
                                        return GestureDetector(
                                          onTap: () =>
                                              BlocProvider.of<LogoutCubit>(
                                                      context)
                                                  .logOut(),
                                          child: Container(
                                            child: Padding(
                                              padding: EdgeInsets.all(2.w),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.logout_rounded,
                                                    size: 14.sp,
                                                    color:
                                                        MyColors.textColorLight,
                                                  ),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  Text(
                                                    "Log out",
                                                    style: TextStyle(
                                                      color: MyColors.white,
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      } else if (state is LogoutLoading) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: MyColors.progressColor,
                                          ),
                                        );
                                      } else if (state is LogoutSucceed) {
                                        return Icon(
                                          Icons.check_rounded,
                                          size: 14.sp,
                                          color: MyColors.textColorLight,
                                        );
                                      } else if (state is LogoutFailed) {
                                        return GestureDetector(
                                          onTap: () =>
                                              BlocProvider.of<LogoutCubit>(
                                                      context)
                                                  .logOut(),
                                          child: Container(
                                            child: Padding(
                                              padding: EdgeInsets.all(2.w),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.logout_rounded,
                                                    size: 14.sp,
                                                    color:
                                                        MyColors.textColorLight,
                                                  ),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  Text(
                                                    "Log out",
                                                    style: TextStyle(
                                                      color: MyColors.white,
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () =>
                                              BlocProvider.of<LogoutCubit>(
                                                      context)
                                                  .logOut(),
                                          child: Container(
                                            child: Padding(
                                              padding: EdgeInsets.all(2.w),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.logout_rounded,
                                                    size: 14.sp,
                                                    color:
                                                        MyColors.textColorLight,
                                                  ),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  Text(
                                                    "Log out",
                                                    style: TextStyle(
                                                      color: MyColors.white,
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (state is SettingFailed) {}
                        return Container();
                      },
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
