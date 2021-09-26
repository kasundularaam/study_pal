import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:study_pal/logic/cubit/pick_date_cubit/pick_date_cubit.dart';

class MDatePicker extends StatefulWidget {
  final Function(DateTime) onSelectDate;
  final Color bgColor;
  final Color txtColor;
  const MDatePicker({
    Key? key,
    required this.onSelectDate,
    required this.bgColor,
    required this.txtColor,
  }) : super(key: key);

  @override
  _MDatePickerState createState() => _MDatePickerState();
}

class _MDatePickerState extends State<MDatePicker> {
  DateTime initialDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(DateTime.now().year - 1),
          lastDate: DateTime(DateTime.now().year + 10),
        );
        if (pickedDate != null) {
          BlocProvider.of<PickDateCubit>(context)
              .pickDate(pickedDate: pickedDate);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.w), color: widget.bgColor),
        child: BlocBuilder<PickDateCubit, PickDateState>(
          builder: (context, state) {
            if (state is PickDatePicked) {
              widget.onSelectDate(state.pickedDate);
              initialDate = state.pickedDate;
              return Center(
                  child: Text(state.pickedDateStr,
                      style:
                          TextStyle(color: widget.txtColor, fontSize: 14.sp)));
            } else {
              return Center(
                  child: Text("Pick a date",
                      style:
                          TextStyle(color: widget.txtColor, fontSize: 14.sp)));
            }
          },
        ),
      ),
    );
  }
}
