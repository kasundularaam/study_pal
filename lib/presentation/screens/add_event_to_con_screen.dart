import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/constants/my_styles.dart';
import 'package:study_pal/core/screen_arguments/add_eve_to_con_scrn_args.dart';
import 'package:study_pal/data/models/add_con_eve_cal_cu_model.dart';
import 'package:study_pal/logic/cubit/add_con_eve_cal_cubit/add_con_eve_cal_cubit.dart';
import 'package:study_pal/logic/cubit/pick_date_cubit/pick_date_cubit.dart';
import 'package:study_pal/logic/cubit/pick_time_cubit/pick_time_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/date_picker.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/success_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/time_picker.dart';
import 'package:study_pal/presentation/templates/inner_scrn_tmpl.dart';

class AddEventToConScreen extends StatefulWidget {
  final AddEveToConScrnArgs args;
  const AddEventToConScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _AddEventToConScreenState createState() => _AddEventToConScreenState();
}

class _AddEventToConScreenState extends State<AddEventToConScreen> {
  DateTime? pickedDate;
  TimeOfDay? pickedTime;
  String title = "";
  @override
  Widget build(BuildContext context) {
    title =
        "${widget.args.subjectName} > ${widget.args.moduleName} > ${widget.args.contentName}";
    return InnerScrnTmpl(
      title: "Set Reminder",
      content: ListView(
        padding: EdgeInsets.all(5.w),
        physics: BouncingScrollPhysics(),
        children: [
          Text("Content",
              style:
                  TextStyle(color: MyColors.textColorLight, fontSize: 16.sp)),
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
              style: TextStyle(color: MyColors.textColorDark, fontSize: 14.sp),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text("Date",
              style:
                  TextStyle(color: MyColors.textColorLight, fontSize: 16.sp)),
          SizedBox(
            height: 2.h,
          ),
          BlocProvider(
            create: (context) => PickDateCubit(),
            child: DatePicker(onSelectDate: (date) => pickedDate = date),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text("time",
              style:
                  TextStyle(color: MyColors.textColorLight, fontSize: 16.sp)),
          SizedBox(
            height: 2.h,
          ),
          BlocProvider(
            create: (context) => PickTimeCubit(),
            child: TimePicker(onPickedTime: (time) => pickedTime = time),
          ),
          SizedBox(
            height: 3.h,
          ),
          BlocBuilder<AddConEventToCalCubit, AddConEventToCalState>(
            builder: (context, state) {
              if (state is AddConEventToCalInitial) {
                return GestureDetector(
                  onTap: () {
                    if (pickedDate != null && pickedTime != null) {
                      BlocProvider.of<AddConEventToCalCubit>(context)
                          .addConEventToCal(
                        addEvCalCuMod: AddConEvCalCuMod(
                          date: pickedDate!,
                          time: pickedTime!,
                          subjectId: widget.args.subjectId,
                          subjectName: widget.args.subjectName,
                          moduleId: widget.args.moduleId,
                          moduleName: widget.args.moduleName,
                          contentId: widget.args.contentId,
                          contentName: widget.args.contentName,
                        ),
                      );
                    } else {
                      print("date or time not picked");
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      color: MyColors.progressColor,
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    child: Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: MyColors.textColorDark,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                );
              } else if (state is AddConEventToCalLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is AddConEventToCalSucceed) {
                return Center(
                    child: SuccessMsgBox(successMsg: "Remainder added"));
              } else if (state is AddConEventToCalFailed) {
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
