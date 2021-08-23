import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/add_eve_to_mod_scrn_args.dart';
import 'package:study_pal/core/screen_arguments/content_list_screen_args.dart';
import 'package:study_pal/core/screen_arguments/content_screen_args.dart';
import 'package:study_pal/core/screen_arguments/module_screen_args.dart';
import 'package:study_pal/core/screen_arguments/quiz_screen_args.dart';
import 'package:study_pal/data/models/content_model.dart';
import 'package:study_pal/logic/cubit/module_screen_cubit/module_screen_cubit.dart';
import 'package:study_pal/presentation/router/app_router.dart';
import 'package:study_pal/presentation/screens/widgets/content_card_small.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';

class ModuleScreen extends StatefulWidget {
  final ModuleScreenArgs args;
  const ModuleScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _ModuleScreenState createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ModuleScreenCubit>(context)
        .loadContentList(moduleId: widget.args.moduleId);
  }

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
                        widget.args.moduleName,
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
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            "Contents",
                            style: TextStyle(
                                color: MyColors.textColorLight,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                          height: 16.h,
                          child:
                              BlocBuilder<ModuleScreenCubit, ModuleScreenState>(
                            builder: (context, state) {
                              if (state is ModuleScreenInitial) {
                                return Center(child: Text("Initial State"));
                              } else if (state is ModuleScreenLoading) {
                                return Center(
                                    child: CircularProgressIndicator(
                                  color: MyColors.progressColor,
                                ));
                              } else if (state is ModuleScreenLoaded) {
                                return ListView(
                                  padding: EdgeInsets.all(0),
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    ListView.builder(
                                      padding: EdgeInsets.all(0),
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: state.contentList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Content content =
                                            state.contentList[index];
                                        return ContentCardSmall(
                                          args: ContentScreenArgs(
                                            contentId: content.id,
                                            contentName: content.contentTitle,
                                            subjectName:
                                                widget.args.subjectName,
                                            subjectId: widget.args.subjectId,
                                            moduleName: widget.args.moduleName,
                                            moduleId: widget.args.moduleId,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              } else if (state is ModuleScreenFailed) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: ErrorMsgBox(errorMsg: state.errorMsg),
                                );
                              } else if (state is ModuleScreenNoResult) {
                                return Center(
                                    child:
                                        ErrorMsgBox(errorMsg: state.message));
                              } else {
                                return Center(
                                  child: ErrorMsgBox(
                                      errorMsg: "unhandled state excecuted!"),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRouter.contentListScreen,
                              arguments: ContentListScreenArgs(
                                subjectId: widget.args.subjectId,
                                subjectName: widget.args.subjectName,
                                moduleId: widget.args.moduleId,
                                moduleName: widget.args.moduleName,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "See All",
                                  style: TextStyle(
                                    color: MyColors.textColorLight,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: MyColors.textColorLight,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Divider(
                            color: MyColors.textColorLight,
                            thickness: 0.2.w,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "Add to schedule work later",
                              style: TextStyle(
                                color: MyColors.textColorLight,
                                fontSize: 14.sp,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRouter.addEventToModScreen,
                                arguments: AddEveToModScrnArgs(
                                  subjectId: widget.args.subjectId,
                                  subjectName: widget.args.subjectName,
                                  moduleId: widget.args.moduleId,
                                  moduleName: widget.args.moduleName,
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 1.h),
                                decoration: BoxDecoration(
                                  color: MyColors.hpTopCardBgColor,
                                  borderRadius: BorderRadius.circular(2.w),
                                ),
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                    color: MyColors.textColorLight,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Divider(
                            color: MyColors.textColorLight,
                            thickness: 0.2.w,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            "Questions",
                            style: TextStyle(
                                color: MyColors.textColorLight,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRouter.quizScreen,
                              arguments: QuizScreenArgs(
                                moduleId: widget.args.moduleId,
                                moduleName: widget.args.moduleName,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: MyColors.hpTopCardBgColor,
                                borderRadius: BorderRadius.circular(2.w),
                              ),
                              child: Text(
                                "Go To Quiz",
                                style: TextStyle(
                                    color: MyColors.textColorLight,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
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
