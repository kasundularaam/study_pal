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
import 'package:study_pal/presentation/templates/inner_scrn_tmpl.dart';

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
    return InnerScrnTmpl(
      title: widget.args.subjectName,
      content: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        children: [
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: MyTextField(
              onChanged: (text) => BlocProvider.of<SubjectScreenCubit>(context)
                  .loadSearchList(searchTxt: text),
              onSubmitted: (text) {},
              textInputAction: TextInputAction.search,
              isPassword: false,
              hintText: "Search modules...",
              textColor: MyColors.textColorDark,
              bgColor: MyColors.white.withOpacity(0.7),
            ),
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
                return Center(child: ErrorMsgBox(errorMsg: state.message));
              } else if (state is SubjectScreenFailed) {
                return Center(child: ErrorMsgBox(errorMsg: state.errorMsg));
              } else {
                return Text("unhandled state excecuted!");
              }
            },
          ),
        ],
      ),
    );
  }
}
