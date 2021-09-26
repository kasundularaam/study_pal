import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/logic/cubit/pick_time_cubit/pick_time_cubit.dart';

class TimePicker extends StatefulWidget {
  final Function(TimeOfDay) onPickedTime;
  const TimePicker({
    Key? key,
    required this.onPickedTime,
  }) : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay initialTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: initialTime,
        );
        if (pickedTime != null) {
          BlocProvider.of<PickTimeCubit>(context)
              .pickTime(pickedTime: pickedTime);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.w),
            color: MyColors.darkColor.withOpacity(0.1)),
        child: BlocBuilder<PickTimeCubit, PickTimeState>(
          builder: (context, state) {
            if (state is PickTimeInitial) {
              return Center(
                child: Text("Pick a time",
                    style: TextStyle(
                        color: MyColors.textColorDark, fontSize: 14.sp)),
              );
            } else if (state is PickTimePicked) {
              initialTime = state.pickedTime;
              widget.onPickedTime(
                state.pickedTime,
              );
              return Center(
                child: Text(state.pickedTimeStr,
                    style: TextStyle(
                        color: MyColors.textColorDark, fontSize: 14.sp)),
              );
            } else {
              return Center(
                child: Text("Pick a date",
                    style: TextStyle(
                        color: MyColors.textColorDark, fontSize: 14.sp)),
              );
            }
          },
        ),
      ),
    );
  }
}
