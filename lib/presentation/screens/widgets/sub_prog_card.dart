import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:study_pal/logic/cubit/sub_prog_card_cubit/sub_prog_card_cubit.dart';
import 'package:study_pal/logic/cubit/sub_prog_cubit/sub_prog_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/blur_bg.dart';
import 'package:study_pal/presentation/screens/widgets/sub_prog_card_item.dart';

class SubProgCard extends StatelessWidget {
  const SubProgCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SubProgCardCubit>(context).getSubjects();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.w),
        boxShadow: [
          BoxShadow(
              color: MyColors.darkColor.withOpacity(0.1),
              offset: Offset(1, 1),
              blurRadius: 4,
              spreadRadius: 4)
        ],
      ),
      child: BlurBg(
        borderRadius: BorderRadius.circular(5.w),
        child: Container(
          width: 100.w,
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            color: MyColors.lightColor.withOpacity(0.6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Summary",
                style: TextStyle(
                    color: MyColors.textColorDark,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2.h,
              ),
              BlocBuilder<SubProgCardCubit, SubProgCardState>(
                builder: (context, state) {
                  if (state is SubProgCardLoaded) {
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        children:
                            builedItemList(subjectList: state.subjectList),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Loading...",
                        style: TextStyle(
                            color: MyColors.textColorDark,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> builedItemList({required List<Subject> subjectList}) {
    List<Widget> itemList = [];
    subjectList.forEach((subject) {
      itemList.add(
        BlocProvider(
          create: (context) => SubProgCubit(),
          child: SubProgCardItem(
            subject: subject,
          ),
        ),
      );
    });
    return itemList;
  }
}
