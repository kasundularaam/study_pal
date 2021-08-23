import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/core/my_enums.dart';
import 'package:study_pal/logic/cubit/auth_cubit/auth_cubit.dart';
import 'package:study_pal/logic/cubit/auth_nav_cubit/authscreen_nav_cubit.dart';
import 'package:study_pal/logic/cubit/login_cubit/login_cubit.dart';
import 'package:study_pal/logic/cubit/select_sub_list_cubit/select_sub_list_cubit.dart';
import 'package:study_pal/logic/cubit/select_subject_cubit/select_subject_cubit.dart';
import 'package:study_pal/logic/cubit/signup_cubit/signup_cubit.dart';
import 'package:study_pal/presentation/screens/auth_pages/auth_page.dart';
import 'package:study_pal/presentation/screens/auth_pages/login_page.dart';
import 'package:study_pal/presentation/screens/auth_pages/select_subject_page.dart';
import 'package:study_pal/presentation/screens/auth_pages/signup_page.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthscreenNavCubit>(context).emit(AuthscreenNavInitial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.authScrnBgClr,
      body: SafeArea(
        child: BlocBuilder<AuthscreenNavCubit, AuthscreenNavState>(
          builder: (context, state) {
            if (state is AuthscreenNavInitial) {
              return BlocProvider(
                create: (context) => AuthCubit(),
                child: AuthPage(),
              );
            } else if (state is AuthscreenNavigate) {
              if (state.authNav == AuthNav.toLogin) {
                return BlocProvider(
                  create: (context) => LoginCubit(),
                  child: LoginPage(),
                );
              } else if (state.authNav == AuthNav.toSignUp) {
                return BlocProvider(
                  create: (context) => SignupCubit(),
                  child: SignUpPage(),
                );
              } else if (state.authNav == AuthNav.toAuthPage) {
                return BlocProvider(
                  create: (context) => AuthCubit(),
                  child: AuthPage(),
                );
              } else if (state.authNav == AuthNav.toSelectSubjectPage) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<SelectSubListCubit>(
                      create: (context) => SelectSubListCubit(),
                    ),
                    BlocProvider<SelectSubjectCubit>(
                      create: (context) => SelectSubjectCubit(),
                    )
                  ],
                  child: SelectSubjectPage(),
                );
              } else {
                return Center(
                    child: ErrorMsgBox(errorMsg: "sorry no page available!"));
              }
            } else {
              return Center(
                  child: ErrorMsgBox(errorMsg: "unhandled state excecuted!"));
            }
          },
        ),
      ),
    );
  }
}
