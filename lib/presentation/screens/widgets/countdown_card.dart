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
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
                color: MyColors.lightColor,
                borderRadius: BorderRadius.circular(5.w)),
            child: Column(
              children: [
                BlocBuilder<CountdownCubit, CountdownState>(
                  builder: (context, state) {
                    if (state is CountdownRunning) {
                      return Text(
                        state.countdown,
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600),
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
                Text(
                  countdown.examTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: MyColors.darkColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
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
