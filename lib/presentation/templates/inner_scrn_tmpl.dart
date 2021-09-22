import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/constants/my_styles.dart';

class InnerScrnTmpl extends StatefulWidget {
  final String title;
  final String? subtitle;
  final Widget content;
  const InnerScrnTmpl({
    Key? key,
    required this.title,
    this.subtitle,
    required this.content,
  }) : super(key: key);

  @override
  _InnerScrnTmplState createState() => _InnerScrnTmplState();
}

class _InnerScrnTmplState extends State<InnerScrnTmpl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
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
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              widget.title,
                              style: MyStyles.screenTitles,
                            ),
                            widget.subtitle != null
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                        widget.subtitle!,
                                        style: MyStyles.screenSubtitles,
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    height: 2.h,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.w),
                      topRight: Radius.circular(8.w),
                    ),
                    child: Container(
                      color: MyColors.white,
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset(
                                  "assets/images/bg_bottom_art.png")),
                          widget.content,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
