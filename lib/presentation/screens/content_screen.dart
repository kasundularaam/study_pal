import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/add_eve_to_con_scrn_args.dart';
import 'package:study_pal/core/screen_arguments/content_screen_args.dart';
import 'package:study_pal/logic/cubit/download_pdf_cubit/download_pdf_cubit.dart';
import 'package:study_pal/presentation/router/app_router.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';

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
                        width: 100.w,
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                        child: Column(
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
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      BlocBuilder<DownloadPdfCubit, DownloadPdfState>(
                        builder: (context, state) {
                          if (state is DownloadPdfInitial) {
                            return GestureDetector(
                              onTap: () =>
                                  BlocProvider.of<DownloadPdfCubit>(context)
                                      .downloadPdf(
                                          moduleId: widget.args.moduleId,
                                          contentId: widget.args.contentId),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Container(
                                  padding: EdgeInsets.all(5.w),
                                  decoration: BoxDecoration(
                                    color: MyColors.hpTopCardBgColor,
                                    borderRadius: BorderRadius.circular(5.w),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Download Content As a PDF",
                                      style: TextStyle(
                                        color: MyColors.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else if (state is DownloadPdfLoading) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: MyColors.progressColor,
                            ));
                          } else if (state is DownloadPdfFailed) {
                            return Column(
                              children: [
                                ErrorMsgBox(errorMsg: state.errorMsg),
                                SizedBox(
                                  height: 2.h,
                                ),
                                TextButton(
                                    onPressed: () =>
                                        BlocProvider.of<DownloadPdfCubit>(
                                                context)
                                            .emit(DownloadPdfInitial()),
                                    child: Text(
                                      "Retry",
                                      style: TextStyle(
                                        color: MyColors.progressColor,
                                        fontSize: 16.sp,
                                      ),
                                    )),
                              ],
                            );
                          } else {
                            return Center(
                              child: ErrorMsgBox(
                                  errorMsg: "unhandled state excecuted!"),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Divider(
                        color: MyColors.progressColor,
                        thickness: 0.2.w,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRouter.workingScreen,
                          arguments: widget.args,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5.w),
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          decoration: BoxDecoration(
                            color: MyColors.progressColor,
                            borderRadius: BorderRadius.circular(5.w),
                          ),
                          child: Center(
                            child: Text(
                              "Start Working",
                              style: TextStyle(
                                color: MyColors.textColorDark,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
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
                          padding: EdgeInsets.all(5.w),
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          decoration: BoxDecoration(
                            color: MyColors.progressColor,
                            borderRadius: BorderRadius.circular(5.w),
                          ),
                          child: Center(
                            child: Text(
                              "Add to schedule",
                              style: TextStyle(
                                color: MyColors.textColorDark,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
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
