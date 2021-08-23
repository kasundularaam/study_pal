import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';

class ErrorMsgBox extends StatelessWidget {
  final String errorMsg;
  const ErrorMsgBox({
    Key? key,
    required this.errorMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
      decoration: BoxDecoration(
        color: MyColors.errorBackground,
        borderRadius: BorderRadius.circular(1.3.w),
      ),
      child: Text(
        errorMsg,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: MyColors.primaryError,
          fontSize: 13.sp,
        ),
      ),
    );
  }
}
