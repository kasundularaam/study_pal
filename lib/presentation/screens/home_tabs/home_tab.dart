import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:study_pal/logic/cubit/home_tab_cubit/home_tab_cubit.dart';
import 'package:study_pal/logic/cubit/subject_card_cubit/subject_card_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/home_top_card.dart';
import 'package:study_pal/presentation/screens/widgets/subject_card.dart';
import 'package:study_pal/presentation/templates/home_tabs_tmpl.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeTabCubit>(context).loadSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return HomeTabsTmpl(
      title: "Home",
      content: Container(
        child: BlocBuilder<HomeTabCubit, HomeTabState>(
          builder: (context, state) {
            if (state is HomeTabInitial) {
              return Center(child: Text("Initial State"));
            } else if (state is HomeTabLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: MyColors.progressColor,
                ),
              );
            } else if (state is HomeTabLoaded) {
              return ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  HomeTopCard(
                    subjectList: state.subjectList,
                  ),
                  ListView.builder(
                      padding: EdgeInsets.all(0),
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.subjectList.length,
                      itemBuilder: (context, index) {
                        Subject subject = state.subjectList[index];
                        Color color = MyColors.subjectColors[index];
                        return BlocProvider(
                          create: (context) => SubjectCardCubit(),
                          child: SubjectCard(
                            subject: subject,
                            color: color,
                          ),
                        );
                      })
                ],
              );
            } else if (state is HomeTabFailed) {
              return ListView(
                children: [
                  Center(
                    child: Column(
                      children: [
                        ErrorMsgBox(errorMsg: state.errorMsg),
                        SizedBox(
                          height: 5.h,
                        ),
                        TextButton(
                          onPressed: () =>
                              BlocProvider.of<HomeTabCubit>(context)
                                  .loadSubjects(),
                          child: Text(
                            "Try Again",
                            style: TextStyle(
                              color: MyColors.titleClr,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text("unhandled state excecuted!"));
            }
          },
        ),
      ),
    );
  }
}
