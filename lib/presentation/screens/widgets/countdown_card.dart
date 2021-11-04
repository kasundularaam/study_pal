import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/data/models/countdown_model.dart';
import 'package:study_pal/logic/cubit/countdown_cubit/countdown_cubit.dart';

class CountdownCard extends StatelessWidget {
  final Countdown countdown;
  final Function showOptions;
  const CountdownCard({
    Key? key,
    required this.countdown,
    required this.showOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CountdownCubit>(context)
        .runCounter(examTimeStmp: countdown.examTimeStamp);
    return Column(
      children: [
        GestureDetector(
          onLongPress: () => showOptions(),
          child: Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 5.w),
            decoration: BoxDecoration(
                color: MyColors.lightColor,
                borderRadius: BorderRadius.circular(5.w)),
            child: Column(
              children: [
                BlocBuilder<CountdownCubit, CountdownState>(
                  builder: (context, state) {
                    if (state is CountdownRunning) {
                      return Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 12.h,
                              margin: EdgeInsets.symmetric(horizontal: 1.w),
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: MyColors.primaryColor,
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      state.daysStr,
                                      style: TextStyle(
                                          color: MyColors.lightColor,
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "Days",
                                      style: TextStyle(
                                          color: MyColors.lightColor,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 12.h,
                              padding: EdgeInsets.all(2.w),
                              margin: EdgeInsets.symmetric(horizontal: 1.w),
                              decoration: BoxDecoration(
                                color: MyColors.primaryColor,
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      state.hoursStr,
                                      style: TextStyle(
                                          color: MyColors.lightColor,
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "Hours",
                                      style: TextStyle(
                                          color: MyColors.lightColor,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 12.h,
                              padding: EdgeInsets.all(2.w),
                              margin: EdgeInsets.symmetric(horizontal: 1.w),
                              decoration: BoxDecoration(
                                color: MyColors.primaryColor,
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      state.minutesStr,
                                      style: TextStyle(
                                          color: MyColors.lightColor,
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "Minutes",
                                      style: TextStyle(
                                          color: MyColors.lightColor,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 12.h,
                              padding: EdgeInsets.all(2.w),
                              margin: EdgeInsets.symmetric(horizontal: 1.w),
                              decoration: BoxDecoration(
                                color: MyColors.primaryColor,
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      state.secondsStr,
                                      style: TextStyle(
                                          color: MyColors.lightColor,
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "Seconds",
                                      style: TextStyle(
                                          color: MyColors.lightColor,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (state is CountdownEnded) {
                      return Container(
                        child: Text("Ended"),
                      );
                    } else {
                      return Container(
                        child: Text("Loaing..."),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        countdown.examTitle,
                        style: TextStyle(
                          color: MyColors.primaryColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }
}
