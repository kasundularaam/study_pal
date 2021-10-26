import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebse_subject_repo.dart';

part 'quiz_summary_card_state.dart';

class QuizSummaryCardCubit extends Cubit<QuizSummaryCardState> {
  QuizSummaryCardCubit() : super(QuizSummaryCardInitial());

  Future<void> loadSubjects() async {
    try {
      emit(QuizSummaryLoading());
      List<Subject> subjects = await FirebaseSubjectRepo.getSubjects();
      emit(QuizSummaryLoaded(subjects: subjects));
    } catch (e) {
      emit(QuizSummaryFailed());
    }
  }
}
