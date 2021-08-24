import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:study_pal/logic/cubit/h_t_c_Item_cubit/h_t_c_item_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/h_t_c_item_loading.dart';
import 'package:study_pal/presentation/screens/widgets/prograss_bar.dart';

class HomeTopCardItem extends StatelessWidget {
  final Subject subject;
  const HomeTopCardItem({
    Key? key,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HTCItemCubit>(context)
        .loadSubjectDetails(subjectId: subject.id);
    return BlocBuilder<HTCItemCubit, HTCItemState>(
      builder: (context, state) {
        if (state is HTCItemInitial) {
          return Text("Initial State");
        } else if (state is HTCItemLoading) {
          return Column(
            children: [
              HTCItemLoadingW(),
              SizedBox(
                height: 3.h,
              ),
            ],
          );
        } else if (state is HTCItemLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subject.name,
                style:
                    TextStyle(color: MyColors.textColorDark, fontSize: 14.sp),
              ),
              SizedBox(
                height: 2.w,
              ),
              MyPrograssBar(
                  width: 75.w,
                  max: state.contentCount,
                  progress: state.fireContentCount,
                  backgroundColor: MyColors.white,
                  progressColor: MyColors.progressColor),
              SizedBox(
                height: 3.w,
              ),
            ],
          );
        } else if (state is HTCItemFailed) {
          return Column(
            children: [
              HTCItemLoadingW(),
              SizedBox(
                height: 3.h,
              ),
            ],
          );
        } else {
          return Column(
            children: [
              HTCItemLoadingW(),
              SizedBox(
                height: 3.h,
              ),
            ],
          );
        }
      },
    );
  }
}
