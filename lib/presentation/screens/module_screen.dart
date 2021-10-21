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
import 'package:study_pal/presentation/screens/widgets/small_btn.dart';
import 'package:study_pal/presentation/templates/inner_scrn_tmpl.dart';

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
    return InnerScrnTmpl(
      title: widget.args.moduleName,
      content: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 3.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "Contents",
                        style: TextStyle(
                            color: MyColors.textColorDark,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
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
                                color: MyColors.secondaryColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: MyColors.secondaryColor,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                height: 16.h,
                child: BlocBuilder<ModuleScreenCubit, ModuleScreenState>(
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
                            itemBuilder: (BuildContext context, int index) {
                              Content content = state.contentList[index];
                              return ContentCardSmall(
                                args: ContentScreenArgs(
                                  contentId: content.id,
                                  contentName: content.contentTitle,
                                  subjectName: widget.args.subjectName,
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
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: ErrorMsgBox(errorMsg: state.errorMsg),
                      );
                    } else if (state is ModuleScreenNoResult) {
                      return Center(
                          child: ErrorMsgBox(errorMsg: state.message));
                    } else {
                      return Center(
                        child:
                            ErrorMsgBox(errorMsg: "unhandled state excecuted!"),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "Add schedule to work later",
                        style: TextStyle(
                          color: MyColors.textColorDark,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SmallBtn(
                          btnText: "Add",
                          onPressed: () => Navigator.pushNamed(
                                context,
                                AppRouter.addEventToModScreen,
                                arguments: AddEveToModScrnArgs(
                                  subjectId: widget.args.subjectId,
                                  subjectName: widget.args.subjectName,
                                  moduleId: widget.args.moduleId,
                                  moduleName: widget.args.moduleName,
                                ),
                              ),
                          bgColor: MyColors.secondaryColor,
                          txtColor: MyColors.lightColor),
                      SizedBox(
                        width: 5.w,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Divider(
                  color: MyColors.textColorDark,
                  thickness: 0.2.w,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: Text(
                  "Questions",
                  style: TextStyle(
                      color: MyColors.textColorDark,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "let's practice yourself",
                        style: TextStyle(
                          color: MyColors.textColorDark,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SmallBtn(
                          btnText: "Go To Quiz",
                          onPressed: () => Navigator.pushNamed(
                                context,
                                AppRouter.quizScreen,
                                arguments: QuizScreenArgs(
                                  moduleId: widget.args.moduleId,
                                  moduleName: widget.args.moduleName,
                                ),
                              ),
                          bgColor: MyColors.progressColor,
                          txtColor: MyColors.darkColor),
                      SizedBox(
                        width: 5.w,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
