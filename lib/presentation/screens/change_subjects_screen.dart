import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/change_sub_args.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:study_pal/logic/cubit/change_subjects_cubit/change_subjects_cubit.dart';
import 'package:study_pal/logic/cubit/settings_cubit/setting_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/select_subject_card.dart';

class ChangeSubjectScreen extends StatefulWidget {
  final ChangeSubScrnArgs args;
  const ChangeSubjectScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _ChangeSubjectScreenState createState() => _ChangeSubjectScreenState();
}

class _ChangeSubjectScreenState extends State<ChangeSubjectScreen> {
  List<Subject> subjects = [];
  List<Subject> fireSubjects = [];
  List<String> selectedSubIds = [];
  List<String> fireSubIds = [];
  @override
  void initState() {
    super.initState();
    subjects = widget.args.subjects;
    fireSubjects = widget.args.fireSubjects;
    addFireSubsToSubIds();
  }

  void addFireSubsToSubIds() {
    fireSubjects.forEach((fireSub) {
      selectedSubIds.add(fireSub.id);
      fireSubIds.add(fireSub.id);
    });
  }

  bool isPreSelected({required String subjectId}) {
    if (selectedSubIds.contains(subjectId)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightColor,
      body: SafeArea(
        child: Column(
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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.close,
                          color: MyColors.primaryColor,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "Subjects",
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  BlocConsumer<ChangeSubjectsCubit, ChangeSubjectsState>(
                    listener: (context, state) {
                      if (state is ChangeSubjectsSucceed) {
                        SnackBar succeedSnack =
                            SnackBar(content: Text(state.message));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(succeedSnack);
                        BlocProvider.of<SettingCubit>(context)
                            .loadProfileSettings();
                        Navigator.pop(context);
                      } else if (state is ChangeSubjectsFailed) {
                        SnackBar failedSnack =
                            SnackBar(content: Text(state.errorMsg));
                        ScaffoldMessenger.of(context).showSnackBar(failedSnack);
                      }
                    },
                    builder: (context, state) {
                      if (state is ChangeSubjectsLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: MyColors.progressColor,
                          ),
                        );
                      } else {
                        return OkButton(
                          onPressed: () =>
                              BlocProvider.of<ChangeSubjectsCubit>(context)
                                  .updateSubjects(
                            fireSubjectIds: fireSubIds,
                            selectedSubjectIds: selectedSubIds,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              height: 0.7,
              width: 100.w,
              color: MyColors.darkColor,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 4.h, bottom: 2.h),
                color: MyColors.darkColor.withOpacity(0.07),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  shrinkWrap: true,
                  itemCount: subjects.length,
                  itemBuilder: (BuildContext context, int index) {
                    Subject subject = subjects[index];
                    return SelectSubjectCard(
                        isSelected: isPreSelected(subjectId: subject.id),
                        subject: subject,
                        onSelected: (selectedSub) {
                          if (selectedSubIds.contains(selectedSub.id)) {
                            selectedSubIds.remove(selectedSub.id);
                          } else {
                            selectedSubIds.add(selectedSub.id);
                          }
                          print(selectedSubIds);
                        });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
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
        color: MyColors.primaryColor,
        size: 20.sp,
      ),
    );
  }
}
