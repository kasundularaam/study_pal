import 'package:flutter/cupertino.dart';
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
              if (state is SubProgLoaded) {
                int precentage =
                    ((state.fireContentCount / state.contentCount) * 100)
                        .toInt();
                return Column(
                  children: [
                    Row(
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
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    MyPrograssBar(
                        width: 75.w,
                        max: state.contentCount,
                        progress: state.fireContentCount,
                        backgroundColor: MyColors.white,
                        progressColor: MyColors.progressColor),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Row(
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
                          "...",
                          style: TextStyle(
                              color: MyColors.textColorDark,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    MyPrograssBar(
                      width: 75.w,
                      max: 100,
                      progress: 0,
                      backgroundColor: MyColors.white,
                      progressColor: MyColors.progressColor,
                    ),
                  ],
                );
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
