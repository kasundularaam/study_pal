import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';

class MyTextField extends StatelessWidget {
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final bool isPassword;
  final String hintText;

  const MyTextField({
    Key? key,
    required this.onChanged,
    required this.onSubmitted,
    this.focusNode,
    required this.textInputAction,
    required this.isPassword,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: TextField(
        obscureText: isPassword,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        focusNode: focusNode,
        autofocus: false,
        style: TextStyle(
          fontSize: 14.sp,
          color: MyColors.shadedBlack,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          border: InputBorder.none,
        ),
        textInputAction: textInputAction,
      ),
    );
  }
}
