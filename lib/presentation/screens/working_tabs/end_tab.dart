import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/end_tab_args.dart';
import 'package:study_pal/logic/cubit/add_work_details_cubit/add_work_details_cubit.dart';
import 'package:study_pal/logic/cubit/working_cubit/working_cubit.dart';
import 'package:study_pal/presentation/router/app_router.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/success_msg_box.dart';

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
    return Scaffold(
      backgroundColor: MyColors.screenBgDarkColor,
      body: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Container(
                height: (constraints.maxHeight * 10) / 100,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: EdgeInsets.all(5.w),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: MyColors.textColorLight,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Summary",
                        style: TextStyle(
                            color: MyColors.textColorLight,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: (constraints.maxHeight * 90) / 100,
                decoration: BoxDecoration(
                  color: MyColors.screenBgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.w),
                    topRight: Radius.circular(8.w),
                  ),
                ),
                child: ListView(
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
                              color: MyColors.textColorDark,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Module: ${widget.args.contentScreenArgs.moduleName}",
                            style: TextStyle(
                              color: MyColors.textColorDark,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Content: ${widget.args.contentScreenArgs.contentName}",
                            style: TextStyle(
                              color: MyColors.shadedBlack,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Start time: $startTime",
                            style: TextStyle(
                              color: MyColors.textColorDark,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "End time: $endTime",
                            style: TextStyle(
                              color: MyColors.textColorDark,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Worked time: ${widget.args.clockValue}",
                            style: TextStyle(
                              color: MyColors.textColorDark,
                              fontSize: 18.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    BlocBuilder<AddWorkDetailsCubit, AddWorkDetailsState>(
                      builder: (context, state) {
                        if (state is AddWorkDetailsInitial) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              color: MyColors.hpTopCardBgColor,
                              borderRadius: BorderRadius.circular(5.w),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Did you complete this content?",
                                  style: TextStyle(
                                    color: MyColors.textColorLight,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          BlocProvider.of<AddWorkDetailsCubit>(
                                                  context)
                                              .addWorkDetails(
                                                  isCompleted: false,
                                                  endTabArgs: widget.args),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w, vertical: 3.w),
                                        decoration: BoxDecoration(
                                          color: MyColors.textColorLight,
                                          borderRadius:
                                              BorderRadius.circular(5.w),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Not Yet",
                                            style: TextStyle(
                                                color:
                                                    MyColors.hpTopCardBgColor,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          BlocProvider.of<AddWorkDetailsCubit>(
                                                  context)
                                              .addWorkDetails(
                                                  isCompleted: true,
                                                  endTabArgs: widget.args),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w, vertical: 3.w),
                                        decoration: BoxDecoration(
                                          color: MyColors.progressColor,
                                          borderRadius:
                                              BorderRadius.circular(5.w),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Yes I Did",
                                            style: TextStyle(
                                                color: MyColors.textColorDark,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        } else if (state is AddWorkDetailsLoading) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: MyColors.progressColor,
                          ));
                        } else if (state is AddWorkDetailsSucceed) {
                          if (state.isCompleted) {
                            BlocProvider.of<WorkingCubit>(context).emit(
                                WorkingContentCompleted(
                                    contentName: widget
                                        .args.contentScreenArgs.contentName));
                            return Center(
                                child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: SuccessMsgBox(successMsg: "succeed!"),
                            ));
                          } else {
                            return Column(
                              children: [
                                Center(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: SuccessMsgBox(successMsg: "succeed!"),
                                )),
                                SizedBox(
                                  height: 3.h,
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                          AppRouter.authScreen,
                                          (Route<dynamic> route) => false),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 3.w),
                                    decoration: BoxDecoration(
                                      color: MyColors.progressColor,
                                      borderRadius: BorderRadius.circular(5.w),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.home_outlined,
                                          size: 22.sp,
                                          color: MyColors.textColorDark,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          "Back To Home",
                                          style: TextStyle(
                                            color: MyColors.textColorDark,
                                            fontSize: 16.sp,
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
                          }
                        } else if (state is AddWorkDetailsFailed) {
                          return Column(
                            children: [
                              ErrorMsgBox(errorMsg: state.errorMsg),
                              SizedBox(
                                height: 2.h,
                              ),
                              TextButton(
                                onPressed: () =>
                                    BlocProvider.of<AddWorkDetailsCubit>(
                                            context)
                                        .emit(AddWorkDetailsInitial()),
                                child: Text(
                                  "Retry",
                                  style: TextStyle(
                                    color: MyColors.accentColor,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: ErrorMsgBox(
                                errorMsg: "unhandled state excecuted!"),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
