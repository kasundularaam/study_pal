import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/data/models/question_model.dart';
import 'package:study_pal/logic/cubit/quiz_card_cubit/quiz_card_cubit.dart';
import 'package:study_pal/logic/cubit/select_answer_cubit/select_answer_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/success_msg_box.dart';

class QuizCard extends StatefulWidget {
  final Question question;
  final int index;
  const QuizCard({
    Key? key,
    required this.question,
    required this.index,
  }) : super(key: key);
  @override
  _QuizCardState createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  String selectedAnswer = "";
  List<String> answerList = [];

  @override
  void initState() {
    super.initState();
    answerList = [
      widget.question.answer1,
      widget.question.answer2,
      widget.question.answer3,
      widget.question.correctAnswer,
    ];
    answerList.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100.w,
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            color: MyColors.textColorLight,
            borderRadius: BorderRadius.circular(5.w),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.index}. "
                "${widget.question.question}",
                style:
                    TextStyle(color: MyColors.textColorDark, fontSize: 16.sp),
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                child: BlocBuilder<SelectAnswerCubit, SelectAnswerState>(
                  builder: (context, state) {
                    if (state is SelectAnswerInitial) {
                      return Column(
                        children: initAnswList(),
                      );
                    } else if (state is SelectAnswerSelect) {
                      return Column(
                        children: answBtnListOnSelect(
                            selectedAnsw: state.selectedAnswer),
                      );
                    } else {
                      return Column(
                        children: initAnswList(),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: BlocBuilder<QuizCardCubit, QuizCardState>(
                  builder: (context, state) {
                    if (state is QuizCardInitial) {
                      return TextButton(
                          onPressed: () =>
                              BlocProvider.of<QuizCardCubit>(context)
                                  .checkAnswer(
                                      correctAnswer:
                                          widget.question.correctAnswer,
                                      selectedAnswer: selectedAnswer),
                          child: Text(
                            "Check",
                            style: TextStyle(
                              color: MyColors.textColorDark,
                              fontSize: 16.sp,
                            ),
                          ));
                    } else if (state is QuizCardCorrect) {
                      return SuccessMsgBox(successMsg: "Correct");
                    } else if (state is QuizCardWrong) {
                      return ErrorMsgBox(
                          errorMsg:
                              "WORNG! correct answer is : ${state.correctAnswer}");
                    } else {
                      return TextButton(
                          onPressed: () =>
                              BlocProvider.of<QuizCardCubit>(context)
                                  .checkAnswer(
                                      correctAnswer:
                                          widget.question.correctAnswer,
                                      selectedAnswer: selectedAnswer),
                          child: Text(
                            "Check",
                            style: TextStyle(
                              color: MyColors.hpTopCardBgColor,
                              fontSize: 16.sp,
                            ),
                          ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
      ],
    );
  }

  List<Widget> initAnswList() {
    List<Widget> answBtnList = [];
    answerList.forEach((answer) {
      answBtnList.add(AnswerBtn(
          answer: answer,
          onPressed: () {
            BlocProvider.of<SelectAnswerCubit>(context)
                .selectAnswer(selectedAnswer: answer);
            selectedAnswer = answer;
          },
          txtColor: MyColors.textColorLight,
          bgColor: MyColors.hpTopCardBgColor));
    });
    return answBtnList;
  }

  List<Widget> answBtnListOnSelect({required String selectedAnsw}) {
    List<Widget> answBtnList = [];
    answerList.forEach((answer) {
      if (answer == selectedAnsw) {
        answBtnList.add(AnswerBtn(
            answer: answer,
            onPressed: () {},
            txtColor: MyColors.textColorDark,
            bgColor: MyColors.progressColor));
      } else {
        answBtnList.add(AnswerBtn(
            answer: answer,
            onPressed: () {
              BlocProvider.of<SelectAnswerCubit>(context)
                  .selectAnswer(selectedAnswer: answer);
              selectedAnswer = answer;
            },
            txtColor: MyColors.textColorLight,
            bgColor: MyColors.hpTopCardBgColor));
      }
    });
    return answBtnList;
  }
}

class AnswerBtn extends StatelessWidget {
  final String answer;
  final Function onPressed;
  final Color txtColor;
  final Color bgColor;
  const AnswerBtn({
    Key? key,
    required this.answer,
    required this.onPressed,
    required this.txtColor,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onPressed();
          },
          child: Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(3.w),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                answer,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: txtColor,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        )
      ],
    );
  }
}
