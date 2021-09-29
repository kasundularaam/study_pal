import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/data/models/quiz_check_model.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/logic/cubit/quiz_nav_cubit/quiz_nav_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/check_quiz_card.dart';

class QuizCheckPage extends StatelessWidget {
  final List<QuizCheck> quizChecks;
  const QuizCheckPage({
    Key? key,
    required this.quizChecks,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(0),
            children: [
              SizedBox(
                height: 3.h,
              ),
              ListView.builder(
                itemCount: quizChecks.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                itemBuilder: (context, index) {
                  QuizCheck quizCheck = quizChecks[index];
                  return CheckQuizCard(quizCheck: quizCheck);
                },
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () =>
              BlocProvider.of<QuizNavCubit>(context).emit(QuizNavAttempt()),
          child: Container(
            color: MyColors.lightColor,
            width: 100.w,
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Center(
              child: Text(
                "Quiz",
                style: TextStyle(
                    color: MyColors.primaryColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
