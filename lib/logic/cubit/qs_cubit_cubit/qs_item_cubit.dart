import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/data/http/http_requests.dart';
import 'package:study_pal/data/models/fire_quiz.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_quiz_repo.dart';

part 'qs_item_state.dart';

class QsItemCubit extends Cubit<QsItemState> {
  QsItemCubit() : super(QsItemInitial());

  Future<void> loadQsItemData({required String subjectId}) async {
    try {
      List<FireQuize> fireQuizes =
          await FirebaseQuizRepo.getFireQuizesBySub(subjectId: subjectId);
      int all = await HttpRequests.getQuestionCountBySub(subjectId: subjectId);
      int done = fireQuizes.length;
      int correct = 0;
      int precentage = 0;
      Color color = MyColors.weak;

      for (var i = 0; i < fireQuizes.length; i++) {
        if (fireQuizes[i].isCorrect) {
          correct++;
        }
      }

      precentage = ((correct / done) * 100).round();
      if (precentage < 35) {
        color = MyColors.weak;
      } else if (precentage >= 35 && precentage < 65) {
        color = MyColors.needToBeImprove;
      } else if (precentage >= 65 && precentage < 75) {
        color = MyColors.good;
      } else {
        color = MyColors.grate;
      }

      emit(QsItemLoaded(
          all: all,
          done: done,
          correct: correct,
          color: color,
          precentage: precentage));
    } catch (e) {
      emit(QsItemFailed());
    }
  }
}
