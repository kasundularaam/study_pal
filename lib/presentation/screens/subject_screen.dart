import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/module_screen_args.dart';
import 'package:study_pal/core/screen_arguments/subject_screen_args.dart';
import 'package:study_pal/data/models/module_model.dart';
import 'package:study_pal/logic/cubit/module_card_cubit/module_card_cubit.dart';
import 'package:study_pal/logic/cubit/subject_screen_cubit/subject_screen_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/module_card.dart';
import 'package:study_pal/presentation/screens/widgets/my_text_field.dart';

class SubjectScreen extends StatefulWidget {
  final SubjectScreenArgs args;
  const SubjectScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SubjectScreenCubit>(context)
        .loadModules(subjectId: widget.args.subjectId);
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
                        widget.args.subjectName,
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
                height: (constraints.maxHeight * 90) / 100,
                decoration: BoxDecoration(
                  color: MyColors.screenBgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.w),
                    topRight: Radius.circular(8.w),
                  ),
                ),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: MyTextField(
                          onChanged: (text) =>
                              BlocProvider.of<SubjectScreenCubit>(context)
                                  .loadSearchList(searchTxt: text),
                          onSubmitted: (text) {},
                          textInputAction: TextInputAction.search,
                          isPassword: false,
                          hintText: "Search modules..."),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    BlocBuilder<SubjectScreenCubit, SubjectScreenState>(
                      builder: (context, state) {
                        if (state is SubjectScreenInitial) {
                          return Text("Initial State");
                        } else if (state is SubjectScreenLoading) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: MyColors.progressColor,
                          ));
                        } else if (state is SubjectScreenLoaded) {
                          return ListView.builder(
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: state.moduleList.length,
                            itemBuilder: (BuildContext context, int index) {
                              Module module = state.moduleList[index];
                              return BlocProvider(
                                create: (context) => ModuleCardCubit(),
                                child: ModuleCard(
                                  args: ModuleScreenArgs(
                                    moduleId: module.id,
                                    moduleName: module.moduleName,
                                    subjectId: widget.args.subjectId,
                                    subjectName: widget.args.subjectName,
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (state is SubjectScreenNoResult) {
                          return Center(
                              child: ErrorMsgBox(errorMsg: state.message));
                        } else if (state is SubjectScreenFailed) {
                          return Center(
                              child: ErrorMsgBox(errorMsg: state.errorMsg));
                        } else {
                          return Text("unhandled state excecuted!");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
