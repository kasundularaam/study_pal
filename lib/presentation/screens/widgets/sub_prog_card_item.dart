import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:study_pal/logic/cubit/sub_prog_cubit/sub_prog_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/prograss_bar.dart';

class SubProgCardItem extends StatelessWidget {
  final Subject subject;
  const SubProgCardItem({
    Key? key,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SubProgCubit>(context)
        .getSubProgress(subjectId: subject.id);
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 1.h,
          ),
          BlocBuilder<SubProgCubit, SubProgState>(
            builder: (context, state) {
              if (state is SubProgInitial) {
                return MyPrograssBar(
                  width: 75.w,
                  max: 100,
                  progress: 0,
                  backgroundColor: MyColors.progressBgColor,
                  progressColor: MyColors.progressColor,
                );
              } else if (state is SubProgLoading) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        subject.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: MyColors.textColorDark, fontSize: 16.sp),
                      ),
                    ),
                    Text(
                      "0%",
                      style: TextStyle(
                          color: MyColors.textColorDark, fontSize: 16.sp),
                    ),
                  ],
                );
              } else if (state is SubProgLoaded) {
                int precentage =
                    ((state.fireContentCount / state.contentCount) * 100)
                        .toInt();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        subject.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: MyColors.textColorDark, fontSize: 16.sp),
                      ),
                    ),
                    Text(
                      "$precentage%",
                      style: TextStyle(
                          color: MyColors.textColorDark, fontSize: 16.sp),
                    ),
                  ],
                );
              } else if (state is SubProgFailed) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        subject.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: MyColors.textColorDark, fontSize: 16.sp),
                      ),
                    ),
                    Text(
                      "Error..",
                      style: TextStyle(
                          color: MyColors.textColorDark, fontSize: 16.sp),
                    ),
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        subject.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: MyColors.textColorDark, fontSize: 16.sp),
                      ),
                    ),
                    Text(
                      "Error..",
                      style: TextStyle(
                          color: MyColors.textColorDark, fontSize: 16.sp),
                    ),
                  ],
                );
              }
            },
          ),
          SizedBox(
            height: 2.h,
          ),
          BlocBuilder<SubProgCubit, SubProgState>(
            builder: (context, state) {
              if (state is SubProgInitial) {
                return MyPrograssBar(
                  width: 75.w,
                  max: 100,
                  progress: 0,
                  backgroundColor: MyColors.progressBgColor,
                  progressColor: MyColors.progressColor,
                );
              } else if (state is SubProgLoading) {
                return MyPrograssBar(
                    width: 75.w,
                    max: 100,
                    progress: 0,
                    backgroundColor: MyColors.progressBgColor,
                    progressColor: MyColors.progressColor);
              } else if (state is SubProgLoaded) {
                return MyPrograssBar(
                    width: 75.w,
                    max: state.contentCount,
                    progress: state.fireContentCount,
                    backgroundColor: MyColors.progressBgColor,
                    progressColor: MyColors.progressColor);
              } else if (state is SubProgFailed) {
                return MyPrograssBar(
                    width: 75.w,
                    max: 100,
                    progress: 0,
                    backgroundColor: MyColors.progressBgColor,
                    progressColor: MyColors.progressColor);
              } else {
                return MyPrograssBar(
                    width: 75.w,
                    max: 100,
                    progress: 0,
                    backgroundColor: MyColors.progressBgColor,
                    progressColor: MyColors.progressColor);
              }
            },
          ),
          SizedBox(
            height: 1.h,
          ),
        ],
      ),
    );
  }
}
