import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/logic/cubit/new_event_cubit/new_event_cubit.dart';
import 'package:study_pal/logic/cubit/pick_date_cubit/pick_date_cubit.dart';
import 'package:study_pal/logic/cubit/pick_time_cubit/pick_time_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/date_picker.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/reguler_btn.dart';
import 'package:study_pal/presentation/screens/widgets/success_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/time_picker.dart';
import 'package:study_pal/presentation/templates/inner_scrn_tmpl.dart';

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
    return InnerScrnTmpl(
      title: "Set Reminder",
      content: ListView(
        padding: EdgeInsets.all(5.w),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 2.h,
          ),
          Text("Date",
              style: TextStyle(color: MyColors.darkColor, fontSize: 16.sp)),
          SizedBox(
            height: 2.h,
          ),
          BlocProvider(
            create: (context) => PickDateCubit(),
            child: MDatePicker(
              onSelectDate: (date) => pickedDate = date,
              bgColor: MyColors.lightColor,
              txtColor: MyColors.darkColor,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text("time",
              style: TextStyle(color: MyColors.darkColor, fontSize: 16.sp)),
          SizedBox(
            height: 2.h,
          ),
          BlocProvider(
            create: (context) => PickTimeCubit(),
            child: MTimePicker(
              onPickedTime: (time) => pickedTime = time,
              bgColor: MyColors.lightColor,
              txtColor: MyColors.darkColor,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Text("Description",
              style: TextStyle(color: MyColors.darkColor, fontSize: 16.sp)),
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
              style: TextStyle(color: MyColors.textColorDark, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: "Your reminder description...",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
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
                  child: RegulerBtn(
                    btnText: "Add",
                    onPressed: () {
                      if (pickedDate != null && pickedTime != null) {
                        BlocProvider.of<NewEventCubit>(context).addNewEvent(
                            date: pickedDate!, time: pickedTime!, title: title);
                      } else {
                        print("date or time not picked");
                      }
                    },
                    bgColor: MyColors.secondaryColor,
                    txtColor: MyColors.darkColor,
                  ),
                );
              } else if (state is NewEventLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is NewEventSucceed) {
                return Center(
                    child: SuccessMsgBox(successMsg: "Reminder added"));
              } else if (state is NewEventFailed) {
                return Center(child: ErrorMsgBox(errorMsg: state.errorMsg));
              } else {
                return Text("");
              }
            },
          ),
        ],
      ),
    );
  }
}
