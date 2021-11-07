import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:study_pal/logic/cubit/qs_cubit_cubit/qs_item_cubit.dart';
import 'package:study_pal/logic/cubit/quiz_summary_cubit/quiz_summary_card_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/blur_bg.dart';
import 'package:study_pal/presentation/screens/widgets/qs_item.dart';

class QuizStatsCard extends StatelessWidget {
  const QuizStatsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<QuizSummaryCardCubit>(context).loadSubjects();
    return Container(
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
                "Quiz Summary",
                style: TextStyle(
                    color: MyColors.textColorDark,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2.h,
              ),
              BlocBuilder<QuizSummaryCardCubit, QuizSummaryCardState>(
                builder: (context, state) {
                  if (state is QuizSummaryLoaded) {
                    return Column(
                      children: buildItemList(subjects: state.subjects),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Loading...",
                        style: TextStyle(
                            color: MyColors.textColorDark,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildItemList({required List<Subject> subjects}) {
    List<Widget> itemList = [];
    subjects.forEach((subject) {
      itemList.add(BlocProvider(
        create: (context) => QsItemCubit(),
        child: QsItem(
          subject: subject,
        ),
      ));
    });
    return itemList;
  }
}
