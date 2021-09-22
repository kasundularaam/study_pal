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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 2.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subjects",
                style: TextStyle(
                    color: MyColors.titleClr,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600),
              ),
              BlocConsumer<SelectSubjectCubit, SelectSubjectState>(
                listener: (context, state) {
                  if (state is SelectedSubjectSucceed) {
                    BlocProvider.of<AuthscreenNavCubit>(context)
                        .authNavigate(authNav: AuthNav.toAuthPage);
                  } else if (state is SelectedSubjectFailed) {
                    SnackBar snackBar = SnackBar(content: Text(state.errorMsg));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                builder: (context, state) {
                  if (state is SelectedSubjectLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: MyColors.progressColor,
                      ),
                    );
                  } else {
                    return OkButton(
                      onPressed: () =>
                          BlocProvider.of<SelectSubjectCubit>(context)
                              .updateSubjectList(subjectList: selectedList),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: MyColors.titleClr,
        ),
        SizedBox(
          height: 2.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            "Select your subjects from here",
            style: TextStyle(
                color: MyColors.textColorDark,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        BlocBuilder<SelectSubListCubit, SelectSubListState>(
            builder: (context, state) {
          if (state is SelectSubjectLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: MyColors.progressColor,
              ),
            );
          } else if (state is SelectSubjectLoaded) {
            return Container(
              padding: EdgeInsets.only(top: 4.h, bottom: 2.h),
              color: MyColors.black.withOpacity(0.07),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                  }),
            );
          } else if (state is SelectSubjectFailed) {
            return Center(child: ErrorMsgBox(errorMsg: state.errorMsg));
          } else {
            return Center(
                child: ErrorMsgBox(errorMsg: "unhandled state excecuted!"));
          }
        }),
      ],
    );
  }
}

class OkButton extends StatelessWidget {
  final Function onPressed;
  const OkButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Icon(
        Icons.check,
        color: MyColors.titleClr,
      ),
    );
  }
}
