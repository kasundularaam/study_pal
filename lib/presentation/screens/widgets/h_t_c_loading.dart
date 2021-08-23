import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/presentation/screens/widgets/h_t_c_item_loading.dart';

class HTCLoading extends StatelessWidget {
  const HTCLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      width: 95.w,
      decoration: BoxDecoration(
        color: MyColors.hpTopCardBgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.w),
          bottomLeft: Radius.circular(5.w),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Subjects",
            style: TextStyle(color: MyColors.white, fontSize: 20.sp),
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
    );
  }
}
