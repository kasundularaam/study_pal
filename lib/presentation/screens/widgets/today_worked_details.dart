import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/logic/cubit/today_worls_cubit/today_works_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/indicators_widget.dart';
import 'package:study_pal/presentation/screens/widgets/pie_chart_sections.dart';

class TodayWorkedDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodayWorksCubit>(context).loadTodayWorkCardData();
    return Column(
      children: [
        BlocBuilder<TodayWorksCubit, TodayWorksState>(
          builder: (context, state) {
            if (state is TodayWorksInitial) {
              return Text("Initial State");
            } else if (state is TodayWorksLoading) {
              return Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(5.w)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today Progress",
                      style: TextStyle(
                          color: MyColors.textColorDark, fontSize: 18.sp),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Center(
                      child: Text(
                        state.loadingMsg,
                        style: TextStyle(
                            color: MyColors.textColorDark, fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is TodayWorksLoaded) {
              return Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(5.w)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today Progress",
                      style: TextStyle(
                          color: MyColors.textColorDark, fontSize: 18.sp),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: 100.w,
                          height: 25.h,
                          child: PieChart(
                            PieChartData(
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 0,
                              centerSpaceRadius: 5.w,
                              sections:
                                  getSections(pieDataList: state.pieDataList),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IndicatorsWidget(pieDataList: state.pieDataList),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Divider(
                      color: MyColors.textColorDark,
                      thickness: 0.2.w,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            "${state.workedTime}",
                            style: TextStyle(
                                color: MyColors.textColorDark,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "time worked today",
                            style: TextStyle(
                                color: MyColors.textColorDark, fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is TodayWorksNoWork) {
              return Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(5.w)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today Progress",
                      style: TextStyle(
                          color: MyColors.textColorDark, fontSize: 18.sp),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Divider(
                      color: MyColors.textColorDark,
                      thickness: 0.2.w,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Center(
                      child: Text(
                        state.message,
                        style: TextStyle(
                            color: MyColors.textColorDark, fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is TodayWorksFailed) {
              return Center(child: ErrorMsgBox(errorMsg: state.errorMsg));
            } else {
              return Center(
                child: ErrorMsgBox(errorMsg: "unhandled state excecuted!"),
              );
            }
          },
        ),
        SizedBox(
          height: 3.h,
        ),
      ],
    );
  }
}
