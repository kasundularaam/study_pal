import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/content_screen_args.dart';
import 'package:study_pal/presentation/router/app_router.dart';

class ContentCardSmall extends StatelessWidget {
  final ContentScreenArgs args;
  const ContentCardSmall({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                AppRouter.contentScreen,
                arguments: args,
              ),
              child: Container(
                height: 15.h,
                width: 50.w,
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: Center(
                  child: Text(
                    args.contentName,
                    style: TextStyle(
                      color: MyColors.shadedBlack,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5.w,
            )
          ],
        ),
        SizedBox(
          height: 1.h,
        )
      ],
    );
  }
}
