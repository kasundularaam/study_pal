import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';

class SuccessMsgBox extends StatelessWidget {
  final String successMsg;
  const SuccessMsgBox({
    Key? key,
    required this.successMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      decoration: BoxDecoration(
        color: MyColors.successBackground,
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Center(
        child: Text(
          successMsg,
          style: TextStyle(
              color: MyColors.primarySuccess,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
