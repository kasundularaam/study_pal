import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/logic/cubit/change_password_cubit/change_password_cubit.dart';
import 'package:study_pal/logic/cubit/edit_name_cubit/edit_name_cubit.dart';
import 'package:study_pal/logic/cubit/settings_cubit/setting_cubit.dart';
import 'package:study_pal/presentation/screens/widgets/change_password_card.dart';
import 'package:study_pal/presentation/screens/widgets/change_subjects_card.dart';
import 'package:study_pal/presentation/screens/widgets/edit_name_card.dart';
import 'package:study_pal/presentation/templates/inner_scrn_tmpl.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SettingCubit>(context).loadProfileSettings();
  }

  @override
  Widget build(BuildContext context) {
    return InnerScrnTmpl(
      title: "Edit Profile",
      content: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        children: [
          SizedBox(
            height: 3.h,
          ),
          BlocBuilder<SettingCubit, SettingState>(
            builder: (context, state) {
              if (state is SettingInitial) {
                return Center(child: Text("Initial State"));
              } else if (state is SettingLoading) {
                return Center(
                    child: CircularProgressIndicator(
                  color: MyColors.progressColor,
                ));
              } else if (state is SettingLoaded) {
                return Column(
                  children: [
                    BlocProvider(
                      create: (context) => EditNameCubit(),
                      child: EditNameCard(
                          fireUser: state.fireUser,
                          onSucceed: (message) {
                            SnackBar succeedSnack =
                                SnackBar(content: Text(message));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(succeedSnack);
                          },
                          onError: (error) {
                            SnackBar errorSnack =
                                SnackBar(content: Text(error));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(errorSnack);
                          }),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    BlocProvider(
                      create: (context) => ChangePasswordCubit(),
                      child: ChangePasswordCard(onSucceed: (message) {
                        SnackBar succeedSnack =
                            SnackBar(content: Text(message));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(succeedSnack);
                      }, onFailed: (errorMsg) {
                        SnackBar errorSnack = SnackBar(content: Text(errorMsg));
                        ScaffoldMessenger.of(context).showSnackBar(errorSnack);
                      }),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ChangeSubjectsCard(
                      screenContext: context,
                      fireSubjects: state.fireSubjects,
                      subjects: state.subjects,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                );
              } else if (state is SettingFailed) {}
              return Container();
            },
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}
