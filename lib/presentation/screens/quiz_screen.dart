import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:study_pal/logic/cubit/quiz_nav_cubit/quiz_nav_cubit.dart';
import 'package:study_pal/logic/cubit/quiz_screen_cubit/quiz_screen_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/attempt_quiz_page.dart';
import 'package:study_pal/presentation/screens/widgets/quiz_check_page.dart';
import 'package:study_pal/presentation/templates/inner_scrn_tmpl.dart';

class QuizScreen extends StatelessWidget {
  final String moduleId;
  final String moduleName;
  const QuizScreen({
    Key? key,
    required this.moduleId,
    required this.moduleName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizNavCubit, QuizNavState>(
      builder: (context, state) {
        if (state is QuizNavCheck) {
          return InnerScrnTmpl(
            title: "Answers",
            subtitle: moduleName,
            content: QuizCheckPage(
              quizChecks: state.quizChecks,
            ),
          );
        } else {
          return BlocProvider(
            create: (context) => QuizScreenCubit(),
            child: InnerScrnTmpl(
              title: "Questions",
              subtitle: moduleName,
              content: AttemptQuizPage(
                moduleId: moduleId,
              ),
            ),
          );
        }
      },
    );
  }
}
