import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/logic/cubit/change_pro_pic_cubit/change_pro_pic_cubit.dart';

class ChangeProPicCrd extends StatelessWidget {
  final Function uploaded;
  final Function(String) failed;
  const ChangeProPicCrd({
    Key? key,
    required this.uploaded,
    required this.failed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChangeProPicCubit>(context).loaddProfilePic();
    return Column(
      children: [
        SizedBox(
          height: 5.h,
        ),
        BlocConsumer<ChangeProPicCubit, ChangeProPicState>(
          listener: (context, state) {
            if (state is ChangeProPicUploaded) {
              uploaded();
            } else if (state is ChangeProPicFailed) {
              failed(state.errorMsg);
            }
          },
          builder: (context, state) {
            if (state is ChangeProPicLoading ||
                state is ChangeProPicUploading) {
              return Center(
                child: CircularProgressIndicator(
                  color: MyColors.secondaryColor,
                ),
              );
            } else if (state is ChangeProPicLoaded) {
              return ClipOval(
                child: GestureDetector(
                  onTap: () => BlocProvider.of<ChangeProPicCubit>(context)
                      .uploadProPic(),
                  child: state.profileImage != "null"
                      ? FadeInImage(
                          placeholder: AssetImage("assets/images/boy.jpg"),
                          image: NetworkImage(
                            state.profileImage,
                          ),
                          width: 30.w,
                          height: 30.w,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/images/boy.jpg",
                          width: 30.w,
                          height: 30.w,
                          fit: BoxFit.cover,
                        ),
                ),
              );
            } else {
              return GestureDetector(
                onTap: () =>
                    BlocProvider.of<ChangeProPicCubit>(context).uploadProPic(),
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/boy.jpg",
                    width: 30.w,
                    height: 30.w,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }
          },
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }
}
