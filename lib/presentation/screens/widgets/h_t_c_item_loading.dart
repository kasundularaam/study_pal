import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';

class HTCItemLoadingW extends StatelessWidget {
  const HTCItemLoadingW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10.w,
          height: 4.w,
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(1.w),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          width: 50.w,
          height: 4.w,
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(1.w),
          ),
        ),
      ],
    );
  }
}
