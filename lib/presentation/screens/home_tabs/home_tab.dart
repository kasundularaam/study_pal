import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:study_pal/logic/cubit/home_tab_cubit/home_tab_cubit.dart';
import 'package:study_pal/logic/cubit/subject_card_cubit/subject_card_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/h_t_c_loading.dart';
import 'package:study_pal/presentation/screens/widgets/home_top_card.dart';
import 'package:study_pal/presentation/screens/widgets/subject_card.dart';

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

  List<Subject> subjectList = [];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10.w),
        bottomRight: Radius.circular(10.w),
      ),
      child: Container(
        color: MyColors.screenBgColor,
        child: BlocBuilder<HomeTabCubit, HomeTabState>(
          builder: (context, state) {
            if (state is HomeTabInitial) {
              return Center(child: Text("Initial State"));
            } else if (state is HomeTabLoading) {
              return ListView(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            color: MyColors.textColorLight,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      HTCLoading(),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Center(
                      child: CircularProgressIndicator(
                    color: MyColors.progressColor,
                  )),
                ],
              );
            } else if (state is HomeTabLoaded) {
              return ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            color: MyColors.textColorLight,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      HomeTopCard(
                        subjectList: state.subjectList,
                      ),
                    ],
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
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            color: MyColors.textColorLight,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  HTCLoading(),
                  SizedBox(
                    height: 3.h,
                  ),
                  Center(child: ErrorMsgBox(errorMsg: state.errorMsg))
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
