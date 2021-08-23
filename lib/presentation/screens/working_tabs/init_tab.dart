import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/constants/shared_prefs_keys.dart';
import 'package:study_pal/core/screen_arguments/content_screen_args.dart';
import 'package:study_pal/logic/cubit/timer_cubit/timer_cubit.dart';
import 'package:study_pal/logic/cubit/working_cubit/working_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';

class InitTab extends StatefulWidget {
  final ContentScreenArgs args;
  const InitTab({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _InitTabState createState() => _InitTabState();
}

class _InitTabState extends State<InitTab> {
  Future<void> checkSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isOnWorking = prefs.getBool(SharedPrefsKeys.isOnWorkingKey);
    if (isOnWorking != null) {
      if (isOnWorking) {
        int startTimeStampSp =
            prefs.getInt(SharedPrefsKeys.startTimeStampKey) ?? 0;
        BlocProvider.of<TimerCubit>(context)
            .backToWork(startTimeStampSp: startTimeStampSp);
      } else {
        BlocProvider.of<TimerCubit>(context)
            .emit(TimerInitial(initCounter: "00.00.00"));
      }
    } else {
      BlocProvider.of<TimerCubit>(context)
          .emit(TimerInitial(initCounter: "00.00.00"));
    }
  }

  @override
  void initState() {
    super.initState();
    checkSP();
  }

  @override
  void dispose() {
    BlocProvider.of<TimerCubit>(context).cancelTimer();
    super.dispose();
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
                        "Let's Work",
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
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Center(
                      child: BlocBuilder<TimerCubit, TimerState>(
                        builder: (context, state) {
                          if (state is TimerInitial) {
                            return Container(
                              padding: EdgeInsets.all(5.w),
                              decoration: BoxDecoration(
                                color: MyColors.textColorLight,
                                borderRadius: BorderRadius.circular(5.w),
                              ),
                              child: Text(
                                state.initCounter,
                                style: TextStyle(
                                    color: MyColors.textColorDark,
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            );
                          } else if (state is TimerStarted) {
                            return Container(
                              padding: EdgeInsets.all(5.w),
                              decoration: BoxDecoration(
                                color: MyColors.hpTopCardBgColor,
                                borderRadius: BorderRadius.circular(5.w),
                              ),
                              child: Text(
                                state.startedCounter,
                                style: TextStyle(
                                    color: MyColors.progressColor,
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            );
                          } else if (state is TimerRunning) {
                            return Container(
                              padding: EdgeInsets.all(5.w),
                              decoration: BoxDecoration(
                                color: MyColors.hpTopCardBgColor,
                                borderRadius: BorderRadius.circular(5.w),
                              ),
                              child: Text(
                                state.timeCounter,
                                style: TextStyle(
                                    color: MyColors.progressColor,
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            );
                          } else if (state is TimerEnded) {
                            return Container(
                              padding: EdgeInsets.all(5.w),
                              decoration: BoxDecoration(
                                color: MyColors.progressColor,
                                borderRadius: BorderRadius.circular(5.w),
                              ),
                              child: Text(
                                state.args.clockValue,
                                style: TextStyle(
                                    color: MyColors.textColorDark,
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            );
                          } else {
                            return ErrorMsgBox(errorMsg: "an error occered!");
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      width: 100.w,
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        color: MyColors.textColorLight,
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Subject: ${widget.args.subjectName}",
                            style: TextStyle(
                                color: MyColors.shadedBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Module: ${widget.args.moduleName}",
                            style: TextStyle(
                                color: MyColors.shadedBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Content: ${widget.args.contentName}",
                            style: TextStyle(
                                color: MyColors.shadedBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    BlocBuilder<TimerCubit, TimerState>(
                      builder: (context, state) {
                        if (state is TimerInitial) {
                          return GestureDetector(
                            onTap: () => BlocProvider.of<TimerCubit>(context)
                                .startTimer(
                                    notifMsg: widget.args.contentName,
                                    args: widget.args),
                            child: Container(
                              padding: EdgeInsets.all(5.w),
                              margin: EdgeInsets.symmetric(horizontal: 5.w),
                              decoration: BoxDecoration(
                                color: MyColors.progressColor,
                                borderRadius: BorderRadius.circular(5.w),
                              ),
                              child: Center(
                                child: Text(
                                  "Start",
                                  style: TextStyle(
                                      color: MyColors.textColorDark,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          );
                        } else if (state is TimerStarted) {
                          return Container(
                            padding: EdgeInsets.all(5.w),
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            decoration: BoxDecoration(
                              color: MyColors.rRed,
                              borderRadius: BorderRadius.circular(5.w),
                            ),
                            child: Center(
                              child: Text(
                                "End",
                                style: TextStyle(
                                    color: MyColors.textColorLight,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          );
                        } else if (state is TimerRunning) {
                          return GestureDetector(
                            onTap: () => BlocProvider.of<TimerCubit>(context)
                                .endTimer(contentScreenArgs: widget.args),
                            child: Container(
                              padding: EdgeInsets.all(5.w),
                              margin: EdgeInsets.symmetric(horizontal: 5.w),
                              decoration: BoxDecoration(
                                color: MyColors.rRed,
                                borderRadius: BorderRadius.circular(5.w),
                              ),
                              child: Center(
                                child: Text(
                                  "End",
                                  style: TextStyle(
                                      color: MyColors.textColorLight,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          );
                        } else if (state is TimerEnded) {
                          BlocProvider.of<WorkingCubit>(context).emit(
                            WorkingEnded(
                              args: state.args,
                            ),
                          );
                          return Container();
                        } else {
                          return Container();
                        }
                      },
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
