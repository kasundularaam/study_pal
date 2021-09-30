part of 'change_pro_pic_cubit.dart';

@immutable
abstract class ChangeProPicState {}

class ChangeProPicInitial extends ChangeProPicState {}

class ChangeProPicUploading extends ChangeProPicState {}

class ChangeProPicUploaded extends ChangeProPicState {}

class ChangeProPicLoading extends ChangeProPicState {}

class ChangeProPicLoaded extends ChangeProPicState {
  final String profileImage;
  ChangeProPicLoaded({
    required this.profileImage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChangeProPicLoaded && other.profileImage == profileImage;
  }

  @override
  int get hashCode => profileImage.hashCode;

  @override
  String toString() => 'ChangeProPicLoaded(profileImage: $profileImage)';
}

class ChangeProPicFailed extends ChangeProPicState {
  final String errorMsg;
  ChangeProPicFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChangeProPicFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'ChangeProPicFailed(errorMsg: $errorMsg)';
}
