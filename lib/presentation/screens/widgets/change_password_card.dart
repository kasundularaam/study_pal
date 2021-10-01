import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/logic/cubit/change_password_cubit/change_password_cubit.dart';

class ChangePasswordCard extends StatefulWidget {
  final Function(String) onSucceed;
  final Function(String) onFailed;
  const ChangePasswordCard({
    Key? key,
    required this.onSucceed,
    required this.onFailed,
  }) : super(key: key);

  @override
  _ChangePasswordCardState createState() => _ChangePasswordCardState();
}

class _ChangePasswordCardState extends State<ChangePasswordCard> {
  TextEditingController crntPswrdCntrlr = TextEditingController();
  TextEditingController newPswrdCntrlr = TextEditingController();
  String currentPassword = "";
  String newPassword = "";
  @override
  void initState() {
    super.initState();
    crntPswrdCntrlr.text = "";
    newPswrdCntrlr.text = "";
  }

  @override
  void dispose() {
    crntPswrdCntrlr.dispose();
    newPswrdCntrlr.dispose();
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
            "Change Password",
            style: TextStyle(
              color: MyColors.textColorDark,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextField(
            onChanged: (currentPasswordTxt) =>
                currentPassword = currentPasswordTxt,
            obscureText: true,
            controller: crntPswrdCntrlr,
            style: TextStyle(
              fontSize: 14.sp,
              color: MyColors.textColorDark,
            ),
            decoration: InputDecoration(hintText: "Current Password"),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextField(
            onChanged: (newPasswordTxt) => newPassword = newPasswordTxt,
            obscureText: true,
            controller: newPswrdCntrlr,
            style: TextStyle(
              fontSize: 14.sp,
              color: MyColors.textColorDark,
            ),
            decoration: InputDecoration(hintText: "New Password"),
          ),
          SizedBox(
            height: 2.h,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                listener: (context, state) {
              if (state is ChangePasswordSucceed) {
                crntPswrdCntrlr.text = "";
                newPswrdCntrlr.text = "";
                widget.onSucceed(state.message);
              } else if (state is ChangePasswordFailed) {
                widget.onFailed(state.errorMsg);
              }
            }, builder: (context, state) {
              if (state is ChangePasswordLoading) {
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
              } else {
                return InkWell(
                  onTap: () => BlocProvider.of<ChangePasswordCubit>(context)
                      .changePassword(
                          currentPassword: currentPassword,
                          newPassword: newPassword),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text(
                      "CHANGE",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: MyColors.green,
                      ),
                    ),
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
