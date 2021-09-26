import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:study_pal/core/constants/my_colors.dart';

class HomeTabsTmpl extends StatefulWidget {
  final String title;
  final Widget content;

  final Widget? action;
  const HomeTabsTmpl({
    Key? key,
    required this.title,
    required this.content,
    this.action,
  }) : super(key: key);

  @override
  _HomeTabsTmplState createState() => _HomeTabsTmplState();
}

class _HomeTabsTmplState extends State<HomeTabsTmpl> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10.w),
        bottomRight: Radius.circular(10.w),
      ),
      child: Container(
        color: MyColors.homeTabsBgClr,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/homet.png",
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
            ),
            Container(
              color: MyColors.white.withOpacity(0.7),
            ),
            widget.content,
            Container(
              color: MyColors.homeTabsTopBgClr,
              width: 100.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                          color: MyColors.primaryColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    widget.action ?? SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
