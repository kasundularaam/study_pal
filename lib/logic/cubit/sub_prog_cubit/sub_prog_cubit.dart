import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_content_repo.dart';

part 'sub_prog_state.dart';

class SubProgCubit extends Cubit<SubProgState> {
  SubProgCubit() : super(SubProgInitial());

  Future<void> getSubProgress({required String subjectId}) async {
    try {
      emit(SubProgLoading());
      int contentCount = 3;
      int fireContentCount =
          await FirebaseContentRepo.getCleanedContentsCountBySub(
              subjectId: subjectId);
      emit(SubProgLoaded(
          contentCount: contentCount, fireContentCount: fireContentCount));
    } catch (e) {
      emit(SubProgFailed(errorMsg: e.toString()));
    }
  }
}
