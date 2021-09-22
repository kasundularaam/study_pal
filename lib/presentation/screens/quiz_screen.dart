import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/data/models/question_model.dart';
import 'package:study_pal/logic/cubit/quiz_card_cubit/quiz_card_cubit.dart';
import 'package:study_pal/logic/cubit/quiz_screen_cubit/quiz_screen_cubit.dart';
import 'package:study_pal/logic/cubit/select_answer_cubit/select_answer_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/quiz_card.dart';
import 'package:study_pal/presentation/templates/inner_scrn_tmpl.dart';

class QuizScreen extends StatefulWidget {
  final String moduleId;
  final String moduleName;
  const QuizScreen({
    Key? key,
    required this.moduleId,
    required this.moduleName,
  }) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<QuizScreenCubit>(context)
        .loadQuizList(moduleId: widget.moduleId);
  }

  @override
  Widget build(BuildContext context) {
    return InnerScrnTmpl(
      title: "Questions",
      subtitle: widget.moduleName,
      content: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 3.h,
          ),
          BlocBuilder<QuizScreenCubit, QuizScreenState>(
            builder: (context, state) {
              if (state is QuizScreenInitial) {
                return Text("Initial State");
              } else if (state is QuizScreenLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is QuizScreenLoaded) {
                return ListView.builder(
                    padding: EdgeInsets.all(0),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.quizList.length,
                    itemBuilder: (context, index) {
                      Question question = state.quizList[index];
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => QuizCardCubit(),
                          ),
                          BlocProvider(
                            create: (context) => SelectAnswerCubit(),
                          )
                        ],
                        child: QuizCard(
                          index: index + 1,
                          question: question,
                        ),
                      );
                    });
              } else if (state is QuizScreenNoResults) {
                return Center(child: ErrorMsgBox(errorMsg: state.message));
              } else if (state is QuizScreenFailed) {
                return Center(child: ErrorMsgBox(errorMsg: state.errorMessage));
              } else {
                return Center(
                  child: ErrorMsgBox(errorMsg: "unhandled state excecuted!"),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
