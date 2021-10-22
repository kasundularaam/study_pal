import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:study_pal/logic/cubit/h_t_c_Item_cubit/h_t_c_item_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/blur_bg.dart';
import 'package:study_pal/presentation/screens/widgets/home_top_card_item.dart';

class HomeTopCard extends StatelessWidget {
  final List<Subject> subjectList;
  const HomeTopCard({
    Key? key,
    required this.subjectList,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                color: MyColors.lightColor.withOpacity(0.6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Subjects",
                    style: TextStyle(
                        color: MyColors.textColorDark,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Column(
                    children: builedItemList(subjectList: subjectList),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 3.h,
        )
      ],
    );
  }

  List<Widget> builedItemList({required List<Subject> subjectList}) {
    List<Widget> itemList = [];
    subjectList.forEach((subject) {
      itemList.add(
        BlocProvider(
          create: (context) => HTCItemCubit(),
          child: HomeTopCardItem(
            subject: subject,
          ),
        ),
      );
    });
    return itemList;
  }
}
