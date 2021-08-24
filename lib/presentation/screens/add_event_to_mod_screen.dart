import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/add_eve_to_mod_scrn_args.dart';
import 'package:study_pal/data/models/add_mod_eve_cal_cu_model.dart';
import 'package:study_pal/logic/cubit/add_mod_eve_cal_cubit/add_mod_eve_cal_cubit.dart';
import 'package:study_pal/logic/cubit/pick_date_cubit/pick_date_cubit.dart';
import 'package:study_pal/logic/cubit/pick_time_cubit/pick_time_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/date_picker.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/my_button.dart';
import 'package:study_pal/presentation/screens/widgets/success_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/time_picker.dart';

class AddEventToModScreen extends StatefulWidget {
  final AddEveToModScrnArgs args;
  const AddEventToModScreen({
    Key? key,
    required this.args,
  }) : super(key: key);
  @override
  _AddEventToModScreenState createState() => _AddEventToModScreenState();
}

class _AddEventToModScreenState extends State<AddEventToModScreen> {
  DateTime? pickedDate;
  TimeOfDay? pickedTime;
  String title = "";
  int weekCount = 1;
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    title = "${widget.args.subjectName} > ${widget.args.moduleName}";
    return Scaffold(
      backgroundColor: MyColors.homeScrnBgClr,
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
                          "Set Reminder",
                          style: TextStyle(
                              color: MyColors.textColorLight,
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.w),
                    topRight: Radius.circular(8.w),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/bg_bottom_art.png",
                        width: constraints.maxWidth,
                        height: (constraints.maxHeight * 90) / 100,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: (constraints.maxHeight * 90) / 100,
                        child: ListView(
                          padding: EdgeInsets.all(5.w),
                          physics: BouncingScrollPhysics(),
                          children: [
                            Text("Module",
                                style: TextStyle(
                                    color: MyColors.textColorDark,
                                    fontSize: 16.sp)),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              padding: EdgeInsets.all(5.w),
                              decoration: BoxDecoration(
                                color: MyColors.textColorLight,
                                borderRadius: BorderRadius.circular(2.w),
                              ),
                              child: Text(
                                title,
                                style: TextStyle(
                                    color: MyColors.textColorDark,
                                    fontSize: 14.sp),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              "Date",
                              style: TextStyle(
                                  color: MyColors.textColorDark,
                                  fontSize: 16.sp),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            BlocProvider(
                              create: (context) => PickDateCubit(),
                              child: DatePicker(
                                  onSelectDate: (date) => pickedDate = date),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text("time",
                                style: TextStyle(
                                    color: MyColors.textColorDark,
                                    fontSize: 16.sp)),
                            SizedBox(
                              height: 2.h,
                            ),
                            BlocProvider(
                              create: (context) => PickTimeCubit(),
                              child: TimePicker(
                                  onPickedTime: (time) => pickedTime = time),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text("repete",
                                style: TextStyle(
                                    color: MyColors.textColorDark,
                                    fontSize: 16.sp)),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              padding: EdgeInsets.all(5.w),
                              decoration: BoxDecoration(
                                color: MyColors.textColorLight,
                                borderRadius: BorderRadius.circular(2.w),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Remind me weekly",
                                        style: TextStyle(
                                            color: MyColors.textColorDark,
                                            fontSize: 14.sp),
                                      ),
                                      Switch(
                                          value: switchValue,
                                          onChanged: (value) {
                                            setState(() {
                                              switchValue = value;
                                              if (value) {
                                                weekCount = 2;
                                              } else {
                                                weekCount = 1;
                                              }
                                              print(
                                                  "Here The Week Count $weekCount");
                                            });
                                          }),
                                    ],
                                  ),
                                  switchValue
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "For $weekCount weeks",
                                                  style: TextStyle(
                                                      color: MyColors
                                                          .textColorDark,
                                                      fontSize: 14.sp),
                                                ),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (weekCount > 2) {
                                                            weekCount--;
                                                          }
                                                        });
                                                        print(
                                                            "Here The Week Count $weekCount");
                                                      },
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  2.w),
                                                          decoration: BoxDecoration(
                                                              color: MyColors
                                                                  .extraLight,
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Icon(
                                                              Icons.remove)),
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 1
                                                                    .w),
                                                        padding:
                                                            EdgeInsets.all(5.w),
                                                        decoration: BoxDecoration(
                                                            color: MyColors
                                                                .primaryColor,
                                                            shape: BoxShape
                                                                .circle),
                                                        child: Text(
                                                          "$weekCount",
                                                          style: TextStyle(
                                                              color: MyColors
                                                                  .textColorLight,
                                                              fontSize: 14.sp),
                                                        )),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          weekCount++;
                                                        });
                                                        print(
                                                            "Here The Week Count $weekCount");
                                                      },
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  2.w),
                                                          decoration: BoxDecoration(
                                                              color: MyColors
                                                                  .extraLight,
                                                              shape: BoxShape
                                                                  .circle),
                                                          child:
                                                              Icon(Icons.add)),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            BlocBuilder<AddModEveCalCubit, AddModEveCalState>(
                              builder: (context, state) {
                                if (state is AddModEveCalInitial) {
                                  return Center(
                                    child: MyButton(
                                        btnText: "Add",
                                        onPressed: () {
                                          if (pickedDate != null &&
                                              pickedTime != null) {
                                            BlocProvider.of<
                                                    AddModEveCalCubit>(context)
                                                .addModEveToCal(
                                                    addModEveCalCuMod:
                                                        AddModEveCalCuMod(
                                                            date: pickedDate!,
                                                            time: pickedTime!,
                                                            subjectId: widget
                                                                .args.subjectId,
                                                            subjectName: widget
                                                                .args
                                                                .subjectName,
                                                            moduleId: widget
                                                                .args.moduleId,
                                                            moduleName: widget
                                                                .args
                                                                .moduleName),
                                                    count: weekCount);
                                          } else {
                                            print("date or time not picked");
                                          }
                                        },
                                        bgColor: MyColors.progressColor,
                                        txtColor: MyColors.textColorDark),
                                  );
                                } else if (state is AddModEveCalLoading) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (state is AddModEveCalSucceed) {
                                  return Center(
                                      child: SuccessMsgBox(
                                          successMsg: "Remainder added"));
                                } else if (state is AddModEveCalFailed) {
                                  return Center(
                                      child: ErrorMsgBox(
                                          errorMsg: state.errorMsg));
                                } else {
                                  return Text("");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
