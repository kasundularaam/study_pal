import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:study_pal/logic/cubit/qs_cubit_cubit/qs_item_cubit.dart';

class QsItem extends StatelessWidget {
  final Subject subject;
  const QsItem({
    Key? key,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<QsItemCubit>(context).loadQsItemData(subjectId: subject.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subject.name,
          style: TextStyle(
            color: MyColors.textColorDark,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        BlocBuilder<QsItemCubit, QsItemState>(
          builder: (context, state) {
            if (state is QsItemLoaded) {
              return Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: state.color,
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: MyColors.lightColor,
                          width: 0.5.w,
                        ),
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      child: Text(
                        "All: ${state.all} | Done: ${state.done} | correct: ${state.correct}",
                        style: TextStyle(
                            color: MyColors.lightColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: MyColors.lightColor,
                            width: 0.5.w,
                          )),
                      child: Text(
                        "${state.precentage}%",
                        style: TextStyle(
                            color: MyColors.lightColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  color: MyColors.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2.w),
                ),
              );
            }
          },
        ),
        SizedBox(
          height: 1.5.h,
        ),
      ],
    );
  }
}
