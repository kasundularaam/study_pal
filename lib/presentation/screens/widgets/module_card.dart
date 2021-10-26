import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/module_screen_args.dart';
import 'package:study_pal/logic/cubit/module_card_cubit/module_card_cubit.dart';
import 'package:study_pal/presentation/router/app_router.dart';

class ModuleCard extends StatelessWidget {
  final ModuleScreenArgs args;
  const ModuleCard({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ModuleCardCubit>(context).loadModuleCardDetails(
        subjectId: args.subjectId, moduleId: args.moduleId);
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2.w),
            child: BlocBuilder<ModuleCardCubit, ModuleCardState>(
              builder: (context, state) {
                if (state is ModuleCardLoaded) {
                  return Container(
                    width: 100.w,
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 3.w, color: state.color),
                      ),
                      color: MyColors.textColorLight,
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
                        Row(
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
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    width: 100.w,
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      color: MyColors.lightColor,
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
                      ],
                    ),
                  );
                }
              },
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
