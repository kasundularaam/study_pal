import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/my_enums.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:study_pal/logic/cubit/auth_nav_cubit/authscreen_nav_cubit.dart';
import 'package:study_pal/logic/cubit/select_sub_list_cubit/select_sub_list_cubit.dart';
import 'package:study_pal/logic/cubit/select_subject_cubit/select_subject_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/select_subject_card.dart';

class SelectSubjectPage extends StatefulWidget {
  const SelectSubjectPage({Key? key}) : super(key: key);

  @override
  _SelectSubjectPageState createState() => _SelectSubjectPageState();
}

class _SelectSubjectPageState extends State<SelectSubjectPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SelectSubListCubit>(context).loadSubjectList();
  }

  List<Subject> selectedList = [];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        children: [
          Container(
            height: (constraints.maxHeight * 10) / 100,
            child: Center(
              child: Text(
                "Select your subjects",
                style: TextStyle(
                    color: MyColors.textColorLight,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Container(
            height: (constraints.maxHeight * 75) / 100,
            decoration: BoxDecoration(
              color: MyColors.loginScrnMainClr,
              borderRadius: BorderRadius.circular(8.w),
            ),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 3.h,
                ),
                BlocBuilder<SelectSubListCubit, SelectSubListState>(builder: (
                  context,
                  state,
                ) {
                  if (state is SelectSubjectLoading) {
                    return buildLoadingState();
                  } else if (state is SelectSubjectLoaded) {
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: state.subjectList.length,
                        itemBuilder: (context, index) {
                          Subject subject = state.subjectList[index];
                          return SelectSubjectCard(
                              isSelected: false,
                              subject: subject,
                              onSelected: (sub) {
                                if (selectedList.contains(sub)) {
                                  selectedList.remove(sub);
                                } else {
                                  selectedList.add(sub);
                                }
                              });
                        });
                  } else if (state is SelectSubjectFailed) {
                    return Center(child: ErrorMsgBox(errorMsg: state.errorMsg));
                  } else {
                    return Center(
                        child: ErrorMsgBox(
                            errorMsg: "unhandled state excecuted!"));
                  }
                }),
              ],
            ),
          ),
          Container(
            height: (constraints.maxHeight * 15) / 100,
            child: BlocConsumer<SelectSubjectCubit, SelectSubjectState>(
              listener: (context, state) {
                if (state is SelectedSubjectSucceed) {
                  BlocProvider.of<AuthscreenNavCubit>(context)
                      .authNavigate(authNav: AuthNav.toAuthPage);
                }
              },
              builder: (context, state) {
                if (state is SelectSubjectInitial) {
                  return buildInitialState();
                } else if (state is SelectedSubjectLoading) {
                  return buildLoadingState();
                } else if (state is SelectedSubjectFailed) {
                  return buildFailedState(errorMsg: state.errorMsg);
                } else {
                  return Center(
                      child:
                          ErrorMsgBox(errorMsg: "unhandled state excecuted!"));
                }
              },
            ),
          )
        ],
      );
    });
  }

  Widget buildInitialState() {
    return CheckIconBtn(
      onPressed: () => BlocProvider.of<SelectSubjectCubit>(context)
          .updateSubjectList(subjectList: selectedList),
    );
  }

  Widget buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.progressColor,
      ),
    );
  }

  Widget buildFailedState({required String errorMsg}) {
    return CheckIconBtn(
      onPressed: () => BlocProvider.of<SelectSubjectCubit>(context)
          .updateSubjectList(subjectList: selectedList),
    );
  }
}

class CheckIconBtn extends StatelessWidget {
  final Function onPressed;
  const CheckIconBtn({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => onPressed(),
        child: Icon(
          Icons.check_circle,
          size: 8.h,
          color: MyColors.progressColor,
        ),
      ),
    );
  }
}
