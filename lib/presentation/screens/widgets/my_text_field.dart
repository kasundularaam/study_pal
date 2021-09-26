import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyTextField extends StatelessWidget {
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final bool isPassword;
  final String hintText;
  final Color bgColor;
  final Color textColor;
  const MyTextField({
    Key? key,
    required this.onChanged,
    required this.onSubmitted,
    this.focusNode,
    this.controller,
    required this.textInputAction,
    required this.isPassword,
    required this.hintText,
    required this.bgColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        focusNode: focusNode,
        autofocus: false,
        style: TextStyle(
          fontSize: 14.sp,
          color: textColor,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: textColor.withOpacity(0.7),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          border: InputBorder.none,
        ),
        textInputAction: textInputAction,
      ),
    );
  }
}
