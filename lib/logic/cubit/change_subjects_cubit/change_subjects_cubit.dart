import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebse_subject_repo.dart';
import 'package:study_pal/data/repositories/repository.dart';

part 'change_subjects_state.dart';

class ChangeSubjectsCubit extends Cubit<ChangeSubjectsState> {
  ChangeSubjectsCubit() : super(ChangeSubjectsInitial());

  Future<void> updateSubjects(
      {required List<String> fireSubjectIds,
      required List<String> selectedSubjectIds}) async {
    print("FIRE SUBS: $fireSubjectIds");
    print("SELECT SUBS: $selectedSubjectIds");
    try {
      emit(ChangeSubjectsLoading());
      await deleteSubs(
          fireSubjectIds: fireSubjectIds,
          selectedSubjectIds: selectedSubjectIds);

      List<Subject> subsToAdd =
          await Repository.getSubjectById(subjectIds: selectedSubjectIds);
      print("SUBS TO ADD: $subsToAdd");
      await FirebaseSubjectRepo.addSubjects(subjectList: subsToAdd);
      emit(ChangeSubjectsSucceed(message: "subjects changed successfully"));
    } catch (e) {
      emit(ChangeSubjectsFailed(errorMsg: e.toString()));
    }
  }

  Future<void> deleteSubs(
      {required List<String> fireSubjectIds,
      required List<String> selectedSubjectIds}) async {
    fireSubjectIds.forEach((fireSub) async {
      if (!selectedSubjectIds.contains(fireSub)) {
        await FirebaseSubjectRepo.deleteSubjectById(subjectId: fireSub);
      }
    });
  }
}
