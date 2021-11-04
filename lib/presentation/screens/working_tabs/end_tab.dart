import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/end_tab_args.dart';
import 'package:study_pal/logic/cubit/add_work_details_cubit/add_work_details_cubit.dart';
import 'package:study_pal/logic/cubit/working_cubit/working_cubit.dart';
import 'package:study_pal/presentation/router/app_router.dart';
import 'package:study_pal/presentation/screens/widgets/small_btn.dart';
import 'package:study_pal/presentation/templates/inner_scrn_tmpl.dart';

class EndTab extends StatefulWidget {
  final EndTabArgs args;
  const EndTab({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _EndTabState createState() => _EndTabState();
}

class _EndTabState extends State<EndTab> {
  String startTime = "";
  String endTime = "";
  DateFormat formattedDate = DateFormat('HH:mm:ss');

  @override
  void initState() {
    super.initState();
    startTime = formattedDate.format(
        DateTime.fromMillisecondsSinceEpoch(widget.args.startTimestamp));
    endTime = formattedDate
        .format(DateTime.fromMillisecondsSinceEpoch(widget.args.endTimestamp));
  }

  @override
  Widget build(BuildContext context) {
    return InnerScrnTmpl(
      title: "Summary",
      content: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        children: [
          SizedBox(
            height: 3.h,
          ),
          Container(
            width: 100.w,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(5.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Subject: ${widget.args.contentScreenArgs.subjectName}",
                  style: TextStyle(
                    color: MyColors.darkColor,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Module: ${widget.args.contentScreenArgs.moduleName}",
                  style: TextStyle(
                    color: MyColors.darkColor,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Content: ${widget.args.contentScreenArgs.contentName}",
                  style: TextStyle(
                    color: MyColors.darkColor,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Start Time: $startTime",
                  style: TextStyle(
                    color: MyColors.darkColor,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "End Time: $endTime",
                  style: TextStyle(
                    color: MyColors.darkColor,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Worked Time: ${widget.args.clockValue}",
                  style: TextStyle(
                    color: MyColors.darkColor,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          BlocConsumer<AddWorkDetailsCubit, AddWorkDetailsState>(
            listener: (context, state) {
              if (state is AddWorkDetailsSucceed) {
                if (state.isCompleted) {
                  BlocProvider.of<WorkingCubit>(context).emit(
                    WorkingContentCompleted(
                      contentName: widget.args.contentScreenArgs.contentName,
                    ),
                  );
                }
              }
            },
            builder: (context, state) {
              if (state is AddWorkDetailsLoading) {
                return Center(
                    child: CircularProgressIndicator(
                  color: MyColors.progressColor,
                ));
              } else if (state is AddWorkDetailsSucceed) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: MyColors.lightColor,
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_rounded,
                            color: MyColors.successClr,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            "You Done",
                            style: TextStyle(
                              color: MyColors.successClr,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      state.isCompleted
                          ? SizedBox()
                          : Column(
                              children: [
                                SizedBox(
                                  height: 3.h,
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                          AppRouter.authScreen,
                                          (Route<dynamic> route) => false),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.home_outlined,
                                        size: 22.sp,
                                        color: MyColors.primaryColor,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        "Back To Home",
                                        style: TextStyle(
                                            color: MyColors.primaryColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                );
              } else {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: MyColors.lightColor,
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Did you complete this content?",
                        style: TextStyle(
                          color: MyColors.darkColor,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SmallBtn(
                            btnText: "Not Yet",
                            onPressed: () =>
                                BlocProvider.of<AddWorkDetailsCubit>(context)
                                    .addWorkDetails(
                              isCompleted: false,
                              endTabArgs: widget.args,
                            ),
                            bgColor: MyColors.lightColor,
                            txtColor: MyColors.primaryColor,
                          ),
                          SmallBtn(
                            btnText: "Yes I Did",
                            onPressed: () =>
                                BlocProvider.of<AddWorkDetailsCubit>(context)
                                    .addWorkDetails(
                                        isCompleted: true,
                                        endTabArgs: widget.args),
                            bgColor: MyColors.secondaryColor,
                            txtColor: MyColors.lightColor,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
