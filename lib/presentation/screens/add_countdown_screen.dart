import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/constants/my_styles.dart';

import 'package:study_pal/core/screen_arguments/add_countdown_scrn_args.dart';
import 'package:study_pal/presentation/templates/inner_scrn_tmpl.dart';

class AddCountdownScreen extends StatefulWidget {
  final AddCountdownScrnArgs args;
  const AddCountdownScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _AddCountdownScreenState createState() => _AddCountdownScreenState();
}

class _AddCountdownScreenState extends State<AddCountdownScreen> {
  @override
  Widget build(BuildContext context) {
    return InnerScrnTmpl(
      title: widget.args.add ? "New Countdown" : "Edit Countdown",
      content: ListView(
        padding: EdgeInsets.all(5.w),
        physics: BouncingScrollPhysics(),
        children: [],
      ),
    );
  }
}
