import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/module_screen_args.dart';
import 'package:study_pal/logic/cubit/module_card_cubit/module_card_cubit.dart';
import 'package:study_pal/presentation/router/app_router.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/loading_container.dart';

class ModuleCard extends StatelessWidget {
  final ModuleScreenArgs args;
  const ModuleCard({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ModuleCardCubit>(context)
        .loadModuleCardDetails(moduleId: args.moduleId);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRouter.moduleScreen,
              arguments: ModuleScreenArgs(
                subjectId: args.subjectId,
                subjectName: args.subjectName,
                moduleId: args.moduleId,
                moduleName: args.moduleName,
              ),
            );
          },
          child: Container(
            width: 100.w,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: MyColors.textColorLight,
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  args.moduleName,
                  style: TextStyle(
                    color: MyColors.textColorDark,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                BlocBuilder<ModuleCardCubit, ModuleCardState>(
                  builder: (context, state) {
                    if (state is ModuleCardInitial) {
                      return Text("Initial State");
                    } else if (state is ModuleCardLoading) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LoadingContainer(width: 30.w, height: 1.4.h),
                          LoadingContainer(width: 15.w, height: 1.4.h),
                        ],
                      );
                    } else if (state is ModuleCardLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Contents: ${state.contentCount}",
                            style: TextStyle(
                              color: MyColors.textColorDark,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            "Quiz: ${state.quizCount}",
                            style: TextStyle(
                              color: MyColors.textColorDark,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      );
                    } else if (state is ModuleCardFailed) {
                      return ErrorMsgBox(errorMsg: state.errorMsg);
                    } else {
                      return Center(child: Text("unhandled state excecuted!"));
                    }
                  },
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.w,
        ),
      ],
    );
  }
}
