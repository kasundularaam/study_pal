import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/data/models/question_model.dart';
import 'package:study_pal/data/models/quiz_check_model.dart';
import 'package:study_pal/logic/cubit/select_answer_cubit/select_answer_cubit.dart';

class QuizCard extends StatefulWidget {
  final Question question;
  final Function(QuizCheck) onChecked;
  final int index;
  const QuizCard({
    Key? key,
    required this.question,
    required this.onChecked,
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
            color: MyColors.lightColor,
            borderRadius: BorderRadius.circular(5.w),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.index.toString().padLeft(2, "0")}. "
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
            widget.onChecked(
              QuizCheck(
                id: widget.question.id,
                question: widget.question.question,
                correctAnswer: widget.question.correctAnswer,
                checkedAnswer: answer,
                index: widget.index,
              ),
            );
          },
          txtColor: MyColors.lightColor,
          bgColor: MyColors.primaryColor));
    });
    return answBtnList;
  }

  List<Widget> answBtnListOnSelect({required String selectedAnsw}) {
    List<Widget> answBtnList = [];
    answerList.forEach((answer) {
      if (answer == selectedAnsw) {
        answBtnList.add(
          AnswerBtn(
            answer: answer,
            onPressed: () {},
            txtColor: MyColors.darkColor,
            bgColor: MyColors.secondaryColor,
          ),
        );
      } else {
        answBtnList.add(
          AnswerBtn(
            answer: answer,
            onPressed: () {
              BlocProvider.of<SelectAnswerCubit>(context)
                  .selectAnswer(selectedAnswer: answer);
              selectedAnswer = answer;
              widget.onChecked(
                QuizCheck(
                  id: widget.question.id,
                  question: widget.question.question,
                  correctAnswer: widget.question.correctAnswer,
                  checkedAnswer: answer,
                  index: widget.index,
                ),
              );
            },
            txtColor: MyColors.lightColor,
            bgColor: MyColors.primaryColor,
          ),
        );
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
