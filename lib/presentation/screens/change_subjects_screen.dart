import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/change_sub_args.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:study_pal/logic/cubit/change_subjects_cubit/change_subjects_cubit.dart';
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
      backgroundColor: MyColors.screenBgDarkColor,
      body: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Container(
                height: (constraints.maxHeight * 10) / 100,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: EdgeInsets.all(5.w),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: MyColors.textColorLight,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Change Subjects",
                        style: TextStyle(
                            color: MyColors.textColorLight,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: (constraints.maxHeight * 75) / 100,
                decoration: BoxDecoration(
                  color: MyColors.screenBgColor,
                  borderRadius: BorderRadius.circular(8.w),
                ),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: subjects.length,
                      physics: BouncingScrollPhysics(),
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
                  ],
                ),
              ),
              Container(
                height: (constraints.maxHeight * 15) / 100,
                child: Center(
                    child:
                        BlocConsumer<ChangeSubjectsCubit, ChangeSubjectsState>(
                  listener: (context, state) {
                    if (state is ChangeSubjectsSucceed) {
                      SnackBar succeedSnack =
                          SnackBar(content: Text(state.message));
                      ScaffoldMessenger.of(context).showSnackBar(succeedSnack);
                    } else if (state is ChangeSubjectsFailed) {
                      SnackBar failedSnack =
                          SnackBar(content: Text(state.errorMsg));
                      ScaffoldMessenger.of(context).showSnackBar(failedSnack);
                    }
                  },
                  builder: (context, state) {
                    if (state is ChangeSubjectsLoading) {
                      return CircularProgressIndicator(
                        color: MyColors.progressColor,
                      );
                    } else {
                      return GestureDetector(
                        onTap: () =>
                            BlocProvider.of<ChangeSubjectsCubit>(context)
                                .updateSubjects(
                          fireSubjectIds: fireSubIds,
                          selectedSubjectIds: selectedSubIds,
                        ),
                        child: Icon(
                          Icons.check_circle_rounded,
                          size: 36.sp,
                          color: MyColors.progressColor,
                        ),
                      );
                    }
                  },
                )),
              ),
            ],
          );
        }),
      ),
    );
  }
}
