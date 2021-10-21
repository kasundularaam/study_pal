import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/data/models/cal_event_modle.dart';
import 'package:study_pal/presentation/screens/widgets/blur_bg.dart';

class EventCard extends StatelessWidget {
  final CalEvent calEvent;
  final Function(String) onLongPress;
  const EventCard({
    Key? key,
    required this.calEvent,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dayFormat = DateFormat("dd");
    String day =
        dayFormat.format(DateTime.fromMillisecondsSinceEpoch(calEvent.time));
    DateFormat monYrFormat = DateFormat("MMM•dd");
    String monYear =
        monYrFormat.format(DateTime.fromMillisecondsSinceEpoch(calEvent.time));
    DateFormat timeFormat = DateFormat("HH•mm");
    String formattedTime =
        timeFormat.format(DateTime.fromMillisecondsSinceEpoch(calEvent.time));
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: MyColors.primaryColor),
                  child: Text(
                    day,
                    style: TextStyle(
                        color: MyColors.textColorLight, fontSize: 20.sp),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              child: GestureDetector(
                onLongPress: () => onLongPress(calEvent.id),
                child: BlurBg(
                  borderRadius: BorderRadius.circular(3.w),
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor.withOpacity(0.9),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100.w,
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.w),
                            color: MyColors.white,
                          ),
                          child: Text(
                            calEvent.title,
                            style: TextStyle(
                                color: MyColors.textColorDark, fontSize: 14.sp),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "$monYear at $formattedTime",
                          style: TextStyle(
                              color: MyColors.textColorLight, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 2.h,
        )
      ],
    );
  }
}
