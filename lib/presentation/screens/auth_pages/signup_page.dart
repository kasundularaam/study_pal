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
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: 2.h,
        ),
        Image.asset(
          "assets/images/autht.png",
        ),
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
          textColor: MyColors.textColorDark,
          bgColor: MyColors.black.withOpacity(0.07),
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
          textColor: MyColors.textColorDark,
          bgColor: MyColors.black.withOpacity(0.07),
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
          textColor: MyColors.textColorDark,
          bgColor: MyColors.black.withOpacity(0.07),
        ),
        SizedBox(
          height: 3.h,
        ),
        BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupSucceed) {
              BlocProvider.of<AuthscreenNavCubit>(context)
                  .authNavigate(authNav: AuthNav.toSelectSubjectPage);
            } else if (state is SignupFailed) {
              SnackBar snackBar = SnackBar(content: Text(state.errorMsg));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (state is SignupWithInvalidValue) {
              SnackBar snackBar = SnackBar(content: Text(state.errorMsg));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            if (state is SignupLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: MyColors.progressColor,
                ),
              );
            } else {
              return Center(
                child: MyButton(
                  btnText: "Sign Up",
                  onPressed: () =>
                      BlocProvider.of<SignupCubit>(context).signUpNewUser(
                    email: _email,
                    name: _name,
                    password: _password,
                  ),
                  bgColor: MyColors.loginBtnClr,
                  txtColor: MyColors.loginBtnTxtClr,
                ),
              );
            }
          },
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
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
        )
      ],
    );
  }
}
