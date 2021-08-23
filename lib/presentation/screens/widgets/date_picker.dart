import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/logic/cubit/pick_date_cubit/pick_date_cubit.dart';

class DatePicker extends StatefulWidget {
  final Function(DateTime) onSelectDate;
  const DatePicker({
    Key? key,
    required this.onSelectDate,
  }) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
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
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.w),
            color: MyColors.textColorLight),
        child: BlocBuilder<PickDateCubit, PickDateState>(
          builder: (context, state) {
            if (state is PickDateInitial) {
              return Center(
                  child: Text("Pick a date",
                      style: TextStyle(
                          color: MyColors.textColorDark, fontSize: 14.sp)));
            } else if (state is PickDatePicked) {
              widget.onSelectDate(state.pickedDate);
              initialDate = state.pickedDate;
              return Center(
                  child: Text(state.pickedDateStr,
                      style: TextStyle(
                          color: MyColors.textColorDark, fontSize: 14.sp)));
            } else {
              return Center(
                  child: Text("Pick a date",
                      style: TextStyle(
                          color: MyColors.textColorDark, fontSize: 14.sp)));
            }
          },
        ),
      ),
    );
  }
}
