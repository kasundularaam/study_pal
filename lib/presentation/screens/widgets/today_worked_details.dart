import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/logic/cubit/today_worls_cubit/today_works_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/blur_bg.dart';
import 'package:study_pal/presentation/screens/widgets/indicators_widget.dart';
import 'package:study_pal/presentation/screens/widgets/pie_chart_sections.dart';

class TodayWorkedDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodayWorksCubit>(context).loadTodayWorkCardData();
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.w),
            boxShadow: [
              BoxShadow(
                  color: MyColors.darkColor.withOpacity(0.1),
                  offset: Offset(1, 1),
                  blurRadius: 4,
                  spreadRadius: 4)
            ],
          ),
          child: BlurBg(
            borderRadius: BorderRadius.circular(5.w),
            child: Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                color: MyColors.lightColor.withOpacity(0.6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today Progress",
                    style: TextStyle(
                        color: MyColors.textColorDark,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  BlocBuilder<TodayWorksCubit, TodayWorksState>(
                    builder: (context, state) {
                      if (state is TodayWorksInitial) {
                        return Text("Initial State");
                      } else if (state is TodayWorksLoading) {
                        return Center(
                          child: Text(
                            state.loadingMsg,
                            style: TextStyle(
                                color: MyColors.textColorDark, fontSize: 14.sp),
                          ),
                        );
                      } else if (state is TodayWorksLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                      sections: getSections(
                                          pieDataList: state.pieDataList),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IndicatorsWidget(
                                        pieDataList: state.pieDataList),
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
                                        color: MyColors.textColorDark,
                                        fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else if (state is TodayWorksNoWork) {
                        return Center(
                          child: Text(
                            state.message,
                            style: TextStyle(
                                color: MyColors.textColorDark, fontSize: 14.sp),
                          ),
                        );
                      } else {
                        return Center(
                            child: Text(
                          "...",
                          style: TextStyle(
                              color: MyColors.textColorDark, fontSize: 14.sp),
                        ));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
