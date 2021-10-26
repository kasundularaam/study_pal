import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_content_repo.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_module_repo.dart';
import 'package:study_pal/data/repositories/repository.dart';

part 'subject_card_state.dart';

class SubjectCardCubit extends Cubit<SubjectCardState> {
  SubjectCardCubit() : super(SubjectCardInitial());

  Future<void> loadSubjectCardDetails({required String subjectId}) async {
    try {
      emit(SubjectCardLoading());
      int moduleCount =
          await Repository.getModuleCountBySubId(subjectId: subjectId);
      int completedModules =
          await FirebaseModuleRepo.getFireModuleCount(subjectId: subjectId);
      int contentCount = 3;
      int completedContents =
          await FirebaseContentRepo.getCleanedContentsCountBySub(
              subjectId: subjectId);
      Random random = Random();
      int quizCount = random.nextInt(8) + 4;
      emit(SubjectCardLoaded(
          moduleCount: moduleCount,
          completedModules: completedModules,
          contentCount: contentCount,
          completedContents: completedContents,
          quizCount: quizCount));
    } catch (e) {
      emit(SubjectCardFailed(errorMsg: e.toString()));
    }
  }
}
