import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/presentation/router/app_router.dart';

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
    return Scaffold(
      backgroundColor: MyColors.screenBgDarkColor,
      body: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Container(
                height: (constraints.maxHeight * 10) / 100,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: EdgeInsets.all(5.w),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: MyColors.textColorLight,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Good Job",
                        style: TextStyle(
                            color: MyColors.textColorLight,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: (constraints.maxHeight * 90) / 100,
                decoration: BoxDecoration(
                  color: MyColors.screenBgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.w),
                    topRight: Radius.circular(8.w),
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.w),
                      decoration: BoxDecoration(
                        color: MyColors.progressColor,
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "GREETINGS",
                            style: TextStyle(
                                color: MyColors.hpTopCardBgColor,
                                fontSize: 36.sp,
                                fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "🎉",
                            style: TextStyle(
                              fontSize: 50.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "congratulations you have successfully completed \n${widget.contentName}.\nkeep working everyday...\nGOOD LUCK!!",
                      style: TextStyle(
                        color: MyColors.textColorLight,
                        fontSize: 18.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil(AppRouter.authScreen,
                                (Route<dynamic> route) => false),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 3.w),
                          decoration: BoxDecoration(
                            color: MyColors.progressColor,
                            borderRadius: BorderRadius.circular(5.w),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.home_outlined,
                                size: 22.sp,
                                color: MyColors.textColorDark,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                "Back To Home",
                                style: TextStyle(
                                  color: MyColors.textColorDark,
                                  fontSize: 16.sp,
                                ),
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
              ),
            ],
          );
        }),
      ),
    );
  }
}
