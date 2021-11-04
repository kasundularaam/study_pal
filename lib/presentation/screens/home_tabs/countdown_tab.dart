import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/add_countdown_scrn_args.dart';
import 'package:study_pal/data/models/countdown_model.dart';
import 'package:study_pal/logic/cubit/countdown_cubit/countdown_cubit.dart';
import 'package:study_pal/logic/cubit/countdown_tab_cubit/countdown_tab_cubit.dart';
import 'package:study_pal/presentation/router/app_router.dart';
import 'package:study_pal/presentation/screens/widgets/countdown_card.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/templates/home_tabs_tmpl.dart';

class CountDownTab extends StatefulWidget {
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
        child: Icon(
          Icons.add_alarm_rounded,
          color: MyColors.secondaryColor,
          size: 22.sp,
        ),
      ),
      content: ListView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(0),
        children: [
          SizedBox(
            height: 10.h,
          ),
          BlocBuilder<CountdownTabCubit, CountdownTabState>(
              builder: (context, state) {
            if (state is CountdownTabLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: MyColors.progressColor,
                ),
              );
            } else if (state is CountdownTabLoaded) {
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  itemCount: state.countdowns.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Countdown countdown = state.countdowns[index];
                    return BlocProvider(
                      create: (context) => CountdownCubit(),
                      child: CountdownCard(
                        showOptions: () => showModalBottomSheet(
                          context: context,
                          builder: (bSContext) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(bSContext);
                                  Navigator.pushNamed(
                                    bSContext,
                                    AppRouter.addCountdownScreen,
                                    arguments: AddCountdownScrnArgs(
                                      add: false,
                                      countdown: countdown,
                                    ),
                                  );
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 1.2.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.h),
                                      color: MyColors.primaryColor
                                          .withOpacity(0.1)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.edit_rounded,
                                        color: MyColors.secondaryColor,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        "Edit",
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(bSContext);
                                  BlocProvider.of<CountdownTabCubit>(context)
                                      .deleteCountdown(
                                          countdownId: countdown.countdownId,
                                          index: index);
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 1.2.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.h),
                                      color: MyColors.primaryColor
                                          .withOpacity(0.1)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.delete_rounded,
                                        color: MyColors.rRed,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        "Delete",
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
                          ),
                        ),
                        countdown: countdown,
                      ),
                    );
                  });
            } else {
              return Center(
                child: ErrorMsgBox(
                  errorMsg: "No Exams Found",
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
