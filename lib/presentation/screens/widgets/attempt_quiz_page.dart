import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/quiz_screen_args.dart';
import 'package:study_pal/data/models/question_model.dart';
import 'package:study_pal/data/models/quiz_check_model.dart';
import 'package:study_pal/logic/cubit/quiz_nav_cubit/quiz_nav_cubit.dart';
import 'package:study_pal/logic/cubit/quiz_screen_cubit/quiz_screen_cubit.dart';
import 'package:study_pal/logic/cubit/select_answer_cubit/select_answer_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/quiz_card.dart';
import 'package:study_pal/presentation/templates/inner_scrn_tmpl.dart';

class AttemptQuizPage extends StatelessWidget {
  final QuizScreenArgs args;
  const AttemptQuizPage({
    Key? key,
    required this.args,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<QuizScreenCubit>(context)
        .loadQuizList(subjectId: args.subjectId, moduleId: args.moduleId);
    List<QuizCheck> quizChecks = [];
    return InnerScrnTmpl(
      title: "Questions",
      subtitle: args.moduleName,
      action: InkWell(
        onTap: () => showModalBottomSheet(
            context: context,
            builder: (bottomSheetContext) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text(
                      "Reset Progress",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: MyColors.darkColor,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<QuizScreenCubit>(context).resetProgress(
                          subjectId: args.subjectId, moduleId: args.moduleId);
                      Navigator.pop(bottomSheetContext);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.w, vertical: 1.2.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.h),
                          color: MyColors.primaryColor.withOpacity(0.1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.restore_rounded,
                            color: MyColors.rRed,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            "Reset",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: MyColors.darkColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
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
            }),
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: Icon(
            Icons.more_vert_rounded,
            color: MyColors.lightColor,
            size: 20.sp,
          ),
        ),
      ),
      content: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 3.h,
                ),
                BlocConsumer<QuizScreenCubit, QuizScreenState>(
                  listener: (context, state) {
                    if (state is QuizScreenNoResults) {
                      SnackBar snackBar =
                          SnackBar(content: Text(state.message));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (state is QuizScreenFailed) {
                      SnackBar snackBar =
                          SnackBar(content: Text(state.errorMessage));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  builder: (context, state) {
                    if (state is QuizScreenLoading) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: MyColors.secondaryColor,
                      ));
                    } else if (state is QuizScreenLoaded) {
                      return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.quizList.length,
                          itemBuilder: (context, index) {
                            Question question = state.quizList[index];
                            return BlocProvider(
                              create: (context) => SelectAnswerCubit(),
                              child: QuizCard(
                                index: index + 1,
                                question: question,
                                onChecked: (quizCheck) {
                                  bool contains = false;
                                  quizChecks.forEach((quizCheckFor) {
                                    if (quizCheckFor.id == quizCheck.id) {
                                      contains = true;
                                      quizCheckFor.checkedAnswer =
                                          quizCheck.checkedAnswer;
                                    }
                                  });
                                  if (!contains) {
                                    quizChecks.add(quizCheck);
                                  }
                                },
                              ),
                            );
                          });
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => BlocProvider.of<QuizNavCubit>(context)
                .checkAnswers(quizChecks: quizChecks),
            child: Container(
              color: MyColors.lightColor,
              width: 100.w,
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Center(
                child: Text(
                  "Check",
                  style: TextStyle(
                      color: MyColors.primaryColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
