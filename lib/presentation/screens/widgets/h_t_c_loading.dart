import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/presentation/screens/widgets/blur_bg.dart';
import 'package:study_pal/presentation/screens/widgets/h_t_c_item_loading.dart';

class HTCLoading extends StatelessWidget {
  const HTCLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurBg(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5.w),
        bottomLeft: Radius.circular(5.w),
      ),
      child: Container(
        padding: EdgeInsets.all(5.w),
        width: 95.w,
        decoration: BoxDecoration(color: MyColors.white.withOpacity(0.9)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Subjects",
              style: TextStyle(
                  color: MyColors.textColorDark,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 3.h,
            ),
            HTCItemLoadingW(),
            SizedBox(
              height: 3.h,
            ),
            HTCItemLoadingW(),
          ],
        ),
      ),
    );
  }
}
