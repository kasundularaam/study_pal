import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/subject_screen_args.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:study_pal/logic/cubit/subject_card_cubit/subject_card_cubit.dart';
import 'package:study_pal/presentation/router/app_router.dart';
import 'package:study_pal/presentation/screens/widgets/blur_bg.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/loading_container.dart';
import 'package:study_pal/presentation/screens/widgets/prograss_bar.dart';

class SubjectCard extends StatelessWidget {
  final Subject subject;
  final Color color;
  const SubjectCard({
    Key? key,
    required this.subject,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SubjectCardCubit>(context)
        .loadSubjectCardDetails(subjectId: subject.id);
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            AppRouter.subjectScreen,
            arguments: SubjectScreenArgs(
              subjectId: subject.id,
              subjectName: subject.name,
            ),
          ),
          child: BlurBg(
            borderRadius: BorderRadius.circular(5.w),
            child: Container(
              width: 90.w,
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.9),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.name,
                    style: TextStyle(
                        color: MyColors.textColorDark,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5.w,
                  ),
                  BlocBuilder<SubjectCardCubit, SubjectCardState>(
                    builder: (context, state) {
                      if (state is SubjectCardInitial) {
                        return Text("Initial State");
                      } else if (state is SubjectCardLoading) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                LoadingContainer(
                                  width: 20.w,
                                  height: 2.5.h,
                                ),
                                LoadingContainer(
                                  width: 30.w,
                                  height: 2.5.h,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                LoadingContainer(
                                  width: 20.w,
                                  height: 2.5.h,
                                ),
                                LoadingContainer(
                                  width: 30.w,
                                  height: 2.5.h,
                                )
                              ],
                            )
                          ],
                        );
                      } else if (state is SubjectCardLoaded) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Modules",
                                  style: TextStyle(
                                    color: MyColors.textColorDark,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                        "${state.completedModules}/${state.moduleCount}",
                                        style: TextStyle(
                                            color: MyColors.textColorDark,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400)),
                                    MyPrograssBar(
                                      width: 35.w,
                                      max: state.moduleCount,
                                      progress: state.completedModules,
                                      backgroundColor: MyColors.textColorLight,
                                      progressColor: MyColors.progressColor,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 2.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Contents",
                                    style: TextStyle(
                                      color: MyColors.textColorDark,
                                      fontSize: 16.sp,
                                    )),
                                Column(
                                  children: [
                                    Text(
                                        "${state.completedContents}/${state.contentCount}",
                                        style: TextStyle(
                                            color: MyColors.textColorDark,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400)),
                                    MyPrograssBar(
                                      width: 35.w,
                                      max: state.contentCount,
                                      progress: state.completedContents,
                                      backgroundColor: MyColors.textColorLight,
                                      progressColor: MyColors.progressColor,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text("${state.quizCount} Quiz",
                                  style: TextStyle(
                                    color: MyColors.textColorDark,
                                    fontSize: 14.sp,
                                  )),
                            )
                          ],
                        );
                      } else if (state is SubjectCardFailed) {
                        return Center(
                          child: ErrorMsgBox(
                            errorMsg: state.errorMsg,
                          ),
                        );
                      } else {
                        return Center(
                          child: Text("unhandled state excecuted!"),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.w,
        )
      ],
    );
  }
}
