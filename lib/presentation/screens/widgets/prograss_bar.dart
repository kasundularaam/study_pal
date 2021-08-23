import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class MyPrograssBar extends StatelessWidget {
  final double width;
  final int max;
  final int progress;
  final Color backgroundColor;
  final Color progressColor;
  const MyPrograssBar({
    Key? key,
    required this.width,
    required this.max,
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double countedProgress = (width / max) * progress;
    return ClipRRect(
      borderRadius: BorderRadius.circular(1.h),
      child: Stack(
        children: [
          Container(
            color: backgroundColor,
            height: 2.h,
            width: width,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(1.h),
            child: Container(
              color: progressColor,
              height: 2.h,
              width: countedProgress,
            ),
          ),
        ],
      ),
    );
  }
}
