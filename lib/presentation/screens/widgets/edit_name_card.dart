import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/data/models/fire_user_model.dart';
import 'package:study_pal/logic/cubit/edit_name_cubit/edit_name_cubit.dart';

class EditNameCard extends StatefulWidget {
  final FireUser fireUser;
  final Function(String) onSucceed;
  final Function(String) onError;
  const EditNameCard({
    Key? key,
    required this.fireUser,
    required this.onSucceed,
    required this.onError,
  }) : super(key: key);

  @override
  _EditNameCardState createState() => _EditNameCardState();
}

class _EditNameCardState extends State<EditNameCard> {
  TextEditingController controller = TextEditingController();
  String newName = "";

  @override
  void initState() {
    super.initState();
    controller.text = widget.fireUser.name;
    newName = controller.text;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
          color: MyColors.textColorLight,
          borderRadius: BorderRadius.circular(2.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Name",
            style: TextStyle(
              color: MyColors.textColorDark,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextField(
            onChanged: (text) => newName = text,
            controller: controller,
            style: TextStyle(
              fontSize: 14.sp,
              color: MyColors.textColorDark,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: BlocConsumer<EditNameCubit, EditNameState>(
              listener: (context, state) {
                if (state is EditNameSucceed) {
                  widget.onSucceed(state.message);
                } else if (state is EditNameFailed) {
                  widget.onError(state.errorMsg);
                }
              },
              builder: (context, state) {
                if (state is EditNameInitial) {
                  return InkWell(
                    onTap: () => BlocProvider.of<EditNameCubit>(context)
                        .updateUserName(newName: newName),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: MyColors.green,
                        ),
                      ),
                    ),
                  );
                } else if (state is EditNameLoading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text(
                      "Loading...",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: MyColors.primaryColor,
                      ),
                    ),
                  );
                }
                if (state is EditNameSucceed) {
                  return InkWell(
                    onTap: () => BlocProvider.of<EditNameCubit>(context)
                        .updateUserName(newName: newName),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: MyColors.green,
                        ),
                      ),
                    ),
                  );
                } else if (state is EditNameFailed) {
                  return InkWell(
                    onTap: () => BlocProvider.of<EditNameCubit>(context)
                        .updateUserName(newName: newName),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: MyColors.green,
                        ),
                      ),
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () => BlocProvider.of<EditNameCubit>(context)
                        .updateUserName(newName: newName),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: MyColors.green,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
