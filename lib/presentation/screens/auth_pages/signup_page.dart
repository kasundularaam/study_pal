import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/my_enums.dart';
import 'package:study_pal/logic/cubit/auth_nav_cubit/authscreen_nav_cubit.dart';
import 'package:study_pal/logic/cubit/signup_cubit/signup_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/my_button.dart';
import 'package:study_pal/presentation/screens/widgets/my_text_field.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email = "";
  String _password = "";
  String _name = "";

  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        children: [
          Container(
            height: (constraints.maxHeight * 10) / 100,
            child: Center(
              child: Text(
                "Sign Up",
                style: TextStyle(
                    color: MyColors.textColorLight,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.w),
              topRight: Radius.circular(8.w),
            ),
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/bg_top_art.png",
                  width: constraints.maxWidth,
                  height: (constraints.maxHeight * 90) / 100,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: (constraints.maxHeight * 90) / 100,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(5.w),
                          child: Image.asset("assets/images/stu_text.png")),
                      SizedBox(
                        height: 3.h,
                      ),
                      MyTextField(
                        onChanged: (name) => _name = name,
                        onSubmitted: (_) {
                          _emailFocusNode.requestFocus();
                        },
                        textInputAction: TextInputAction.next,
                        isPassword: false,
                        hintText: "Name",
                        textColor: MyColors.white,
                        bgColor: MyColors.black.withOpacity(0.3),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      MyTextField(
                        onChanged: (email) => _email = email,
                        onSubmitted: (_) {
                          _passwordFocusNode.requestFocus();
                        },
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        isPassword: false,
                        hintText: "Email",
                        textColor: MyColors.white,
                        bgColor: MyColors.black.withOpacity(0.3),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      MyTextField(
                        onChanged: (password) => _password = password,
                        onSubmitted: (_) {},
                        textInputAction: TextInputAction.next,
                        isPassword: true,
                        focusNode: _passwordFocusNode,
                        hintText: "Password",
                        textColor: MyColors.white,
                        bgColor: MyColors.black.withOpacity(0.3),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      BlocConsumer<SignupCubit, SignupState>(
                        listener: (context, state) {
                          if (state is SignupSucceed) {
                            BlocProvider.of<AuthscreenNavCubit>(context)
                                .authNavigate(
                                    authNav: AuthNav.toSelectSubjectPage);
                          }
                        },
                        builder: (context, state) {
                          if (state is SignupInitial) {
                            return buildInitState();
                          } else if (state is SignupLoading) {
                            return buildLoadingState();
                          } else if (state is SignupFailed) {
                            return buildFailedState(state.errorMsg);
                          } else if (state is SignupWithInvalidValue) {
                            return buildInvalidValueState(state.errorMsg);
                          } else {
                            return Center(
                                child: ErrorMsgBox(
                                    errorMsg: "unhandled state excecuted!"));
                          }
                        },
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget buildInitState() {
    return Column(
      children: [
        MyButton(
          btnText: "Sign Up",
          onPressed: () => BlocProvider.of<SignupCubit>(context).signUpNewUser(
            email: _email,
            name: _name,
            password: _password,
          ),
          bgColor: MyColors.loginBtnClr,
          txtColor: MyColors.loginBtnTxtClr,
        ),
        SizedBox(
          height: 3.h,
        ),
        goToLogIn(),
      ],
    );
  }

  Widget goToLogIn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Do you have an account? ",
          style: TextStyle(
            fontSize: 14.sp,
            color: MyColors.goToSignClr,
          ),
        ),
        GestureDetector(
          onTap: () => BlocProvider.of<AuthscreenNavCubit>(context)
              .authNavigate(authNav: AuthNav.toLogin),
          child: Text(
            "Log In",
            style: TextStyle(
                fontSize: 14.sp,
                color: MyColors.goToSignClr,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget buildInvalidValueState(String errorMsg) {
    return Column(
      children: [
        ErrorMsgBox(errorMsg: errorMsg),
        SizedBox(
          height: 3.h,
        ),
        MyButton(
          btnText: "Sign Up",
          onPressed: () => BlocProvider.of<SignupCubit>(context).signUpNewUser(
            email: _email,
            name: _name,
            password: _password,
          ),
          bgColor: MyColors.loginBtnClr,
          txtColor: MyColors.loginBtnTxtClr,
        ),
        SizedBox(
          height: 3.h,
        ),
        goToLogIn(),
      ],
    );
  }

  Widget buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.progressColor,
      ),
    );
  }

  Widget buildFailedState(String errorMsg) {
    return Column(children: [
      ErrorMsgBox(errorMsg: errorMsg),
      SizedBox(
        height: 3.h,
      ),
      GestureDetector(
        onTap: () => BlocProvider.of<SignupCubit>(context).emit(
          SignupInitial(),
        ),
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: Text(
            "Try again",
            style: TextStyle(
                fontSize: 14.sp,
                color: MyColors.tryAgainClr,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      SizedBox(
        height: 3.h,
      ),
      goToLogIn(),
    ]);
  }
}
