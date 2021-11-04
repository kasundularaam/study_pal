import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/presentation/router/app_router.dart';
import 'package:study_pal/presentation/templates/inner_scrn_tmpl.dart';

class CongratulationsTab extends StatefulWidget {
  final String contentName;
  const CongratulationsTab({
    Key? key,
    required this.contentName,
  }) : super(key: key);

  @override
  _CongratulationsTabState createState() => _CongratulationsTabState();
}

class _CongratulationsTabState extends State<CongratulationsTab> {
  @override
  Widget build(BuildContext context) {
    return InnerScrnTmpl(
      title: "Good Job",
      content: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 3.h,
          ),
          Image.asset("assets/images/done.png"),
          SizedBox(
            height: 5.h,
          ),
          Center(
            child: Text(
              "CONGRATULATIONS",
              style: TextStyle(
                  color: MyColors.primaryColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            "You have successfully completed \n${widget.contentName}.\nkeep working everyday...\nGOOD LUCK!!",
            style: TextStyle(
              color: MyColors.darkColor,
              fontSize: 13.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 3.h,
          ),
          Center(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouter.authScreen, (Route<dynamic> route) => false),
              child: Container(
                padding:
                    EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  color: MyColors.lightColor,
                  borderRadius: BorderRadius.circular(5.h),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.home_outlined,
                      size: 20.sp,
                      color: MyColors.primaryColor,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      "Back To Home",
                      style: TextStyle(
                          color: MyColors.primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
        ],
      ),
    );
  }
}
