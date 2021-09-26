import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';

import 'package:study_pal/core/screen_arguments/add_countdown_scrn_args.dart';
import 'package:study_pal/logic/cubit/pick_date_cubit/pick_date_cubit.dart';
import 'package:study_pal/logic/cubit/pick_time_cubit/pick_time_cubit.dart';
import 'package:study_pal/logic/cubit/set_countdown_cubit/set_countdown_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/date_picker.dart';
import 'package:study_pal/presentation/screens/widgets/my_text_field.dart';
import 'package:study_pal/presentation/screens/widgets/reguler_btn.dart';
import 'package:study_pal/presentation/screens/widgets/time_picker.dart';
import 'package:study_pal/presentation/templates/inner_scrn_tmpl.dart';

class AddCountdownScreen extends StatefulWidget {
  final AddCountdownScrnArgs args;
  const AddCountdownScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _AddCountdownScreenState createState() => _AddCountdownScreenState();
}

class _AddCountdownScreenState extends State<AddCountdownScreen> {
  DateTime? pickedDate;
  TimeOfDay? pickedTime;
  String examTitle = "Unknown";
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.args.add ? "" : widget.args.countdown!.examTitle;
  }

  @override
  Widget build(BuildContext context) {
    return InnerScrnTmpl(
      title: widget.args.add ? "New Countdown" : "Edit Countdown",
      content: ListView(
        padding: EdgeInsets.all(5.w),
        physics: BouncingScrollPhysics(),
        children: [
          Text("Exam title",
              style: TextStyle(color: MyColors.darkColor, fontSize: 16.sp)),
          SizedBox(
            height: 2.h,
          ),
          MyTextField(
            controller: controller,
            onChanged: (text) => examTitle = text,
            onSubmitted: (text) => examTitle = text,
            textInputAction: TextInputAction.done,
            isPassword: false,
            hintText: "Title...",
            textColor: MyColors.darkColor,
            bgColor: MyColors.darkColor.withOpacity(0.1),
          ),
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
            child: DatePicker(onSelectDate: (date) => pickedDate = date),
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
            child: TimePicker(onPickedTime: (time) => pickedTime = time),
          ),
          SizedBox(
            height: 5.h,
          ),
          Center(
            child: BlocConsumer<SetCountdownCubit, SetCountdownState>(
                builder: (context, state) {
              if (state is SetCountdownLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: MyColors.progressColor,
                  ),
                );
              } else {
                return RegulerBtn(
                  btnText: widget.args.add ? "Add" : "Update",
                  onPressed: () =>
                      BlocProvider.of<SetCountdownCubit>(context).setCoundown(
                    countdownIdEdit: widget.args.add
                        ? null
                        : widget.args.countdown!.countdownId,
                    examTitle: examTitle,
                    exmTime: pickedTime!,
                    exmDate: pickedDate!,
                  ),
                  bgColor: MyColors.secondaryColor,
                  txtColor: MyColors.darkColor,
                );
              }
            }, listener: (context, state) {
              if (state is SetCountdownFaild) {
                SnackBar snackBar = SnackBar(content: Text(state.errorMsg));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (state is SetCountdownSucceed) {
                SnackBar snackBar = SnackBar(content: Text("coundown set!"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }),
          ),
        ],
      ),
    );
  }
}
