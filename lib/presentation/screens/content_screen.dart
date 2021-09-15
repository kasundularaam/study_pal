import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/add_eve_to_con_scrn_args.dart';
import 'package:study_pal/core/screen_arguments/content_screen_args.dart';
import 'package:study_pal/logic/cubit/download_pdf_cubit/download_pdf_cubit.dart';
import 'package:study_pal/presentation/router/app_router.dart';

class ContentScreen extends StatefulWidget {
  final ContentScreenArgs args;
  const ContentScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DownloadPdfCubit(),
      child: Scaffold(
        backgroundColor: MyColors.homeScrnBgClr,
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
                          widget.args.contentName,
                          style: TextStyle(
                              color: MyColors.textColorLight,
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.w),
                    topRight: Radius.circular(8.w),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/bg_bottom_art.png",
                        width: constraints.maxWidth,
                        height: (constraints.maxHeight * 90) / 100,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: (constraints.maxHeight * 90) / 100,
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          physics: BouncingScrollPhysics(),
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Subject: ${widget.args.subjectName}",
                                  style: TextStyle(
                                    color: MyColors.textColorDark,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "Module: ${widget.args.moduleName}",
                                  style: TextStyle(
                                    color: MyColors.textColorDark,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "Content: ${widget.args.contentName}",
                                  style: TextStyle(
                                    color: MyColors.textColorDark,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Divider(
                              color: MyColors.textColorDark,
                              thickness: 0.2.w,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Download content as a PDF",
                                  style: TextStyle(
                                    color: MyColors.textColorDark,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                BlocConsumer<DownloadPdfCubit,
                                    DownloadPdfState>(
                                  listener: (context, state) {
                                    if (state is DownloadPdfFailed) {
                                      SnackBar snackBar = SnackBar(
                                          content: Text(state.errorMsg));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is DownloadPdfLoading) {
                                      return Center(
                                          child: CircularProgressIndicator(
                                        color: MyColors.progressColor,
                                      ));
                                    } else {
                                      return GestureDetector(
                                        onTap: () => BlocProvider.of<
                                                DownloadPdfCubit>(context)
                                            .downloadPdf(
                                                moduleId: widget.args.moduleId,
                                                contentId:
                                                    widget.args.contentId),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 3.w, vertical: 1.4.h),
                                          decoration: BoxDecoration(
                                            color: MyColors.titleClr,
                                            borderRadius:
                                                BorderRadius.circular(1.w),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Download",
                                              style: TextStyle(
                                                color: MyColors.textColorLight,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Divider(
                              color: MyColors.textColorDark,
                              thickness: 0.2.w,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Start working right now",
                                  style: TextStyle(
                                    color: MyColors.textColorDark,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    AppRouter.workingScreen,
                                    arguments: widget.args,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 1.4.h),
                                    decoration: BoxDecoration(
                                      color: MyColors.progressColor,
                                      borderRadius: BorderRadius.circular(2.w),
                                    ),
                                    child: Text(
                                      "let's go",
                                      style: TextStyle(
                                          color: MyColors.textColorDark,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Divider(
                              color: MyColors.textColorDark,
                              thickness: 0.2.w,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add schedule to work later",
                                  style: TextStyle(
                                    color: MyColors.textColorDark,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    AppRouter.addEventToConScreen,
                                    arguments: AddEveToConScrnArgs(
                                        subjectId: widget.args.subjectId,
                                        subjectName: widget.args.subjectName,
                                        moduleId: widget.args.moduleId,
                                        moduleName: widget.args.moduleName,
                                        contentId: widget.args.contentId,
                                        contentName: widget.args.contentName),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 1.4.h),
                                    decoration: BoxDecoration(
                                      color: MyColors.homeScrnBgClr,
                                      borderRadius: BorderRadius.circular(2.w),
                                    ),
                                    child: Text(
                                      "Add",
                                      style: TextStyle(
                                          color: MyColors.textColorLight,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
