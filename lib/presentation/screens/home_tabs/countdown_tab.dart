import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/add_countdown_scrn_args.dart';
import 'package:study_pal/logic/cubit/countdown_tab_cubit/countdown_tab_cubit.dart';
import 'package:study_pal/presentation/router/app_router.dart';
import 'package:study_pal/presentation/screens/widgets/countdown_edit.dart';
import 'package:study_pal/presentation/screens/widgets/countdown_list.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/templates/home_tabs_tmpl.dart';

class CountDownTab extends StatefulWidget {
  const CountDownTab({Key? key}) : super(key: key);

  @override
  _CountDownTabState createState() => _CountDownTabState();
}

class _CountDownTabState extends State<CountDownTab> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CountdownTabCubit>(context).loadCountdowns();
  }

  @override
  Widget build(BuildContext context) {
    return HomeTabsTmpl(
      title: "Exam Countdown",
      action: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppRouter.addCountdownScreen,
            arguments: AddCountdownScrnArgs(add: true)),
        child: Icon(Icons.add_alarm_rounded, color: MyColors.textColorDark),
      ),
      content: Container(
        child: BlocBuilder<CountdownTabCubit, CountdownTabState>(
          builder: (context, state) {
            if (state is CountdownTabLoading) {
              return Center(
                  child: CircularProgressIndicator(
                color: MyColors.progressColor,
              ));
            } else if (state is CountdownTabLoaded) {
              return CountdownList();
            } else if (state is CountdownTabEdit) {
              return CountdownEdit(
                countdown: state.countdown,
              );
            } else if (state is CountdownTabNew) {
              return CountdownEdit();
            } else if (state is CountdownTabFailed) {
              return Center(
                child: Column(
                  children: [
                    ErrorMsgBox(errorMsg: state.errorMsg),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextButton(
                      onPressed: () =>
                          BlocProvider.of<CountdownTabCubit>(context)
                              .loadCountdowns(),
                      child: Text(
                        "Try Again",
                        style: TextStyle(
                          color: MyColors.titleClr,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
