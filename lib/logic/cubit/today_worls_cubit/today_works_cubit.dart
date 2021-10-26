import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/models/pie_data_model.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_work_repo.dart';

part 'today_works_state.dart';

class TodayWorksCubit extends Cubit<TodayWorksState> {
  TodayWorksCubit() : super(TodayWorksInitial());

  Future<void> loadTodayWorkCardData() async {
    try {
      emit(TodayWorksLoading(loadingMsg: "Loading..."));
      String workedTime = await FirebaseWorkRepo.getTodayWorkedTime();
      List<PieDataModel> pieDataList = await FirebaseWorkRepo.getPieDataList();
      if (workedTime != "00:00:00") {
        emit(
            TodayWorksLoaded(workedTime: workedTime, pieDataList: pieDataList));
      } else {
        emit(TodayWorksNoWork(
            message:
                "You haven't done anything yet...\nTry to keep working\neveryday..!"));
      }
    } catch (e) {
      emit(TodayWorksFailed(errorMsg: e.toString()));
    }
  }
}
