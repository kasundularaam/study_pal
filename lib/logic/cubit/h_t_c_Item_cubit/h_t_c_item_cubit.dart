import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/http/http_requests.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_content_repo.dart';

part 'h_t_c_item_state.dart';

class HTCItemCubit extends Cubit<HTCItemState> {
  HTCItemCubit() : super(HTCItemInitial());

  Future<void> loadSubjectDetails({required String subjectId}) async {
    try {
      emit(HTCItemLoading());
      int contentCount =
          await HttpRequests.getContentCountBySub(subjectId: subjectId);
      int fireContentCount =
          await FirebaseContentRepo.getCleanedContentsCountBySub(
              subjectId: subjectId);
      emit(HTCItemLoaded(
          contentCount: contentCount, fireContentCount: fireContentCount));
    } catch (e) {
      emit(HTCItemFailed(errorMsg: "--"));
    }
  }
}
