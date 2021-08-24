import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/data/models/fire_content.dart';
import 'package:study_pal/presentation/screens/widgets/blur_bg.dart';
import 'package:timeago/timeago.dart' as timeago;

class WorkCard extends StatelessWidget {
  final FireContent fireContent;
  const WorkCard({
    Key? key,
    required this.fireContent,
  }) : super(key: key);

  String workedTimeStr({required int counter}) {
    String hoursStr =
        ((counter / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
    String minutesStr =
        ((counter / 60) % 60).floor().toString().padLeft(2, '0');
    String secondsStr = (counter % 60).floor().toString().padLeft(2, '0');
    String timeString = "$hoursStr" ":" "$minutesStr" ":" "$secondsStr";
    return timeString;
  }

  @override
  Widget build(BuildContext context) {
    String workedTime = workedTimeStr(counter: fireContent.counter);

    return Column(
      children: [
        BlurBg(
          borderRadius: BorderRadius.circular(5.w),
          child: Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: MyColors.white.withOpacity(0.8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        "assets/images/boy.jpg",
                        width: 8.w,
                        height: 8.w,
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      "You",
                      style: TextStyle(
                          color: MyColors.homeTitleClr,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      fireContent.isCompleted
                          ? " completed a content on"
                          : " worked on",
                      style: TextStyle(
                        color: MyColors.textColorDark,
                        fontSize: 14.sp,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(1.w),
                  ),
                  child: Text(
                    "${fireContent.subjectName} > ${fireContent.moduleName} > ${fireContent.contentName}",
                    style: TextStyle(
                      color: MyColors.textColorDark,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "Worked time: $workedTime",
                  style: TextStyle(
                    color: MyColors.textColorDark,
                    fontSize: 12.sp,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    timeago.format(
                      DateTime.fromMillisecondsSinceEpoch(
                        fireContent.startTimestamp,
                      ),
                    ),
                    style: TextStyle(
                      color: MyColors.textColorDark,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 3.h,
        )
      ],
    );
  }
}
