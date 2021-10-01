import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/presentation/templates/inner_scrn_tmpl.dart';

class WorkingOnAnotherTab extends StatefulWidget {
  final String contentName;
  const WorkingOnAnotherTab({
    Key? key,
    required this.contentName,
  }) : super(key: key);

  @override
  _WorkingOnAnotherTabState createState() => _WorkingOnAnotherTabState();
}

class _WorkingOnAnotherTabState extends State<WorkingOnAnotherTab> {
  @override
  Widget build(BuildContext context) {
    return InnerScrnTmpl(
      title: "Warning",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 5.h,
          ),
          Image.asset(
            "assets/images/warning.png",
            width: 100.w,
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            "You are currently working on \n${widget.contentName}\nplease pay your attention to the work",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: MyColors.wAnsFgClr,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
