import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:study_pal/logic/cubit/pick_time_cubit/pick_time_cubit.dart';

class MTimePicker extends StatefulWidget {
  final Function(TimeOfDay) onPickedTime;
  final Color bgColor;
  final Color txtColor;
  const MTimePicker({
    Key? key,
    required this.onPickedTime,
    required this.bgColor,
    required this.txtColor,
  }) : super(key: key);

  @override
  _MTimePickerState createState() => _MTimePickerState();
}

class _MTimePickerState extends State<MTimePicker> {
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
            borderRadius: BorderRadius.circular(2.w), color: widget.bgColor),
        child: BlocBuilder<PickTimeCubit, PickTimeState>(
          builder: (context, state) {
            if (state is PickTimePicked) {
              initialTime = state.pickedTime;
              widget.onPickedTime(
                state.pickedTime,
              );
              return Center(
                child: Text(state.pickedTimeStr,
                    style: TextStyle(color: widget.txtColor, fontSize: 14.sp)),
              );
            } else {
              return Center(
                child: Text("Pick a time",
                    style: TextStyle(color: widget.txtColor, fontSize: 14.sp)),
              );
            }
          },
        ),
      ),
    );
  }
}
