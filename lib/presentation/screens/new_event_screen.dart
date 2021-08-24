import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/logic/cubit/new_event_cubit/new_event_cubit.dart';
import 'package:study_pal/logic/cubit/pick_date_cubit/pick_date_cubit.dart';
import 'package:study_pal/logic/cubit/pick_time_cubit/pick_time_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/date_picker.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/my_button.dart';
import 'package:study_pal/presentation/screens/widgets/success_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/time_picker.dart';

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({Key? key}) : super(key: key);

  @override
  _NewEventScreenState createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  DateTime? pickedDate;
  TimeOfDay? pickedTime;
  String title = "Untitled";

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
                  padding: EdgeInsets.all(5.w),
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Text("Date",
                        style: TextStyle(
                            color: MyColors.textColorLight, fontSize: 16.sp)),
                    SizedBox(
                      height: 2.h,
                    ),
                    BlocProvider(
                      create: (context) => PickDateCubit(),
                      child:
                          DatePicker(onSelectDate: (date) => pickedDate = date),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text("time",
                        style: TextStyle(
                            color: MyColors.textColorLight, fontSize: 16.sp)),
                    SizedBox(
                      height: 2.h,
                    ),
                    BlocProvider(
                      create: (context) => PickTimeCubit(),
                      child:
                          TimePicker(onPickedTime: (time) => pickedTime = time),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text("Description",
                        style: TextStyle(
                            color: MyColors.textColorLight, fontSize: 16.sp)),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      child: TextField(
                        obscureText: false,
                        onChanged: (text) => title = text,
                        autofocus: false,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: TextStyle(
                            color: MyColors.textColorDark, fontSize: 14.sp),
                        decoration: InputDecoration(
                          hintText: "Your reminder description...",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 5.w),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    BlocBuilder<NewEventCubit, NewEventState>(
                      builder: (context, state) {
                        if (state is NewEventInitial) {
                          return Center(
                            child: MyButton(
                              btnText: "Add",
                              onPressed: () {
                                if (pickedDate != null && pickedTime != null) {
                                  BlocProvider.of<NewEventCubit>(context)
                                      .addNewEvent(
                                          date: pickedDate!,
                                          time: pickedTime!,
                                          title: title);
                                } else {
                                  print("date or time not picked");
                                }
                              },
                              bgColor: MyColors.hpTopCardBgColor,
                              txtColor: MyColors.textColorLight,
                            ),
                          );
                        } else if (state is NewEventLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is NewEventSucceed) {
                          return Center(
                              child:
                                  SuccessMsgBox(successMsg: "Remainder added"));
                        } else if (state is NewEventFailed) {
                          return Center(
                              child: ErrorMsgBox(errorMsg: state.errorMsg));
                        } else {
                          return Text("");
                        }
                      },
                    ),
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
