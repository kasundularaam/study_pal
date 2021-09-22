import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';

class MyStyles {
  static const BoxShadow boxShadow = BoxShadow(
      color: Color(0x22000000),
      offset: Offset(2, 2),
      blurRadius: 3,
      spreadRadius: 0);

  static TextStyle screenTitles = TextStyle(
    fontSize: 20.sp,
    color: MyColors.screenTitlesClr,
    fontWeight: FontWeight.bold,
  );

  static TextStyle screenSubtitles = TextStyle(
    fontSize: 18.sp,
    color: MyColors.screenTitlesClr,
  );
}
