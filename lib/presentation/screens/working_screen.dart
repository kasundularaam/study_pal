import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_pal/core/screen_arguments/content_screen_args.dart';
import 'package:study_pal/logic/cubit/add_work_details_cubit/add_work_details_cubit.dart';
import 'package:study_pal/logic/cubit/timer_cubit/timer_cubit.dart';
import 'package:study_pal/logic/cubit/working_cubit/working_cubit.dart';

import 'working_tabs/congratulations_tab.dart';
import 'working_tabs/end_tab.dart';
import 'working_tabs/init_tab.dart';
import 'working_tabs/working_on_another_tab.dart';

class WorkingScreen extends StatefulWidget {
  final ContentScreenArgs args;
  const WorkingScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _WorkingScreenState createState() => _WorkingScreenState();
}

class _WorkingScreenState extends State<WorkingScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WorkingCubit>(context)
        .enteringWorkingScreen(contentId: widget.args.contentId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkingCubit, WorkingState>(
      builder: (context, state) {
        if (state is WorkingInitial) {
          return BlocProvider(
            create: (context) => TimerCubit(),
            child: InitTab(args: widget.args),
          );
        } else if (state is WorkingEnded) {
          return BlocProvider(
            create: (context) => AddWorkDetailsCubit(),
            child: EndTab(
              args: state.args,
            ),
          );
        } else if (state is WorkingContentCompleted) {
          return CongratulationsTab(
            contentName: state.contentName,
          );
        } else if (state is WorkingOnNow) {
          return WorkingOnAnotherTab(contentName: state.workingContentName);
        } else {
          return Scaffold();
        }
      },
    );
  }
}
