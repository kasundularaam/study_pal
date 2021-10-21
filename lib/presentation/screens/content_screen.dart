import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/add_eve_to_con_scrn_args.dart';
import 'package:study_pal/core/screen_arguments/content_screen_args.dart';
import 'package:study_pal/logic/cubit/download_pdf_cubit/download_pdf_cubit.dart';
import 'package:study_pal/presentation/router/app_router.dart';
import 'package:study_pal/presentation/screens/widgets/big_btn.dart';
import 'package:study_pal/presentation/screens/widgets/small_btn.dart';
import 'package:study_pal/presentation/templates/inner_scrn_tmpl.dart';

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
    return InnerScrnTmpl(
      title: "",
      content: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 2.h,
          ),
          Center(
            child: Text(
              widget.args.contentName,
              style: TextStyle(
                color: MyColors.primaryColor,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 2.h,
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
                "Download content",
                style: TextStyle(
                  color: MyColors.textColorDark,
                  fontSize: 14.sp,
                ),
              ),
              BlocConsumer<DownloadPdfCubit, DownloadPdfState>(
                listener: (context, state) {
                  if (state is DownloadPdfFailed) {
                    SnackBar snackBar = SnackBar(content: Text(state.errorMsg));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                builder: (context, state) {
                  if (state is DownloadPdfLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: MyColors.progressColor,
                    ));
                  } else {
                    return SmallBtn(
                      btnText: "Download",
                      onPressed: () =>
                          BlocProvider.of<DownloadPdfCubit>(context)
                              .downloadPdf(
                                  moduleId: widget.args.moduleId,
                                  contentId: widget.args.contentId),
                      bgColor: MyColors.secondaryColor,
                      txtColor: MyColors.lightColor,
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
                "Add schedule to work later",
                style: TextStyle(
                  color: MyColors.textColorDark,
                  fontSize: 14.sp,
                ),
              ),
              SmallBtn(
                  btnText: "Add",
                  onPressed: () => Navigator.pushNamed(
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
                  bgColor: MyColors.secondaryColor,
                  txtColor: MyColors.lightColor),
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
          Text(
            "Start working right now",
            style: TextStyle(
              color: MyColors.textColorDark,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          BigBtn(
              btnText: "Let's go",
              onPressed: () => Navigator.pushNamed(
                    context,
                    AppRouter.workingScreen,
                    arguments: widget.args,
                  ),
              bgColor: MyColors.progressColor,
              txtColor: MyColors.darkColor),
        ],
      ),
    );
  }
}
