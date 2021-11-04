import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/screen_arguments/content_list_screen_args.dart';
import 'package:study_pal/core/screen_arguments/content_screen_args.dart';
import 'package:study_pal/data/models/content_model.dart';
import 'package:study_pal/logic/cubit/content_list_screen_cubit/content_list_screen_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/content_card.dart';
import 'package:study_pal/presentation/screens/widgets/my_text_field.dart';
import 'package:study_pal/presentation/templates/inner_scrn_tmpl.dart';

class ContentListScreen extends StatefulWidget {
  final ContentListScreenArgs args;
  const ContentListScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _ContentListScreenState createState() => _ContentListScreenState();
}

class _ContentListScreenState extends State<ContentListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContentListScreenCubit>(context)
        .loadContentList(moduleId: widget.args.moduleId);
  }

  @override
  Widget build(BuildContext context) {
    return InnerScrnTmpl(
      title: "Contents",
      content: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: MyTextField(
              onChanged: (text) =>
                  BlocProvider.of<ContentListScreenCubit>(context)
                      .loadSearchList(searchText: text),
              onSubmitted: (text) {},
              textInputAction: TextInputAction.search,
              isPassword: false,
              hintText: "Search Contents...",
              textColor: MyColors.textColorDark,
              bgColor: MyColors.white.withOpacity(0.7),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          BlocConsumer<ContentListScreenCubit, ContentListScreenState>(
            listener: (context, state) {
              if (state is ContentListScreenNoResult) {
                SnackBar snackBar = SnackBar(content: Text(state.message));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (state is ContentListScreenFailed) {
                SnackBar snackBar = SnackBar(content: Text(state.errorMsg));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, state) {
              if (state is ContentListScreenLoading) {
                return Center(
                    child: CircularProgressIndicator(
                  color: MyColors.progressColor,
                ));
              } else if (state is ContentListScreenLoaded) {
                return ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: state.contentList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Content content = state.contentList[index];
                    return ContentCard(
                      args: ContentScreenArgs(
                        contentId: content.id,
                        contentName: content.contentTitle,
                        subjectName: widget.args.subjectName,
                        subjectId: widget.args.subjectId,
                        moduleName: widget.args.moduleName,
                        moduleId: widget.args.moduleId,
                      ),
                    );
                  },
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
