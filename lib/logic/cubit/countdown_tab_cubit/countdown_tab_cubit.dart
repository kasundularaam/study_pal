import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/models/countdown_model.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_countdown_repo.dart';

part 'countdown_tab_state.dart';

class CountdownTabCubit extends Cubit<CountdownTabState> {
  CountdownTabCubit() : super(CountdownTabInitial());

  Future<void> loadCountdowns() async {
    try {
      emit(CountdownTabLoading());
      List<Countdown> countdowns = await FirebaseCountdownRepo.getCountdowns();
      emit(CountdownTabLoaded(countdowns: countdowns));
    } catch (e) {
      emit(CountdownTabFailed(errorMsg: e.toString()));
    }
  }

  void goToEdit({required Countdown countdown}) {
    emit(CountdownTabEdit(countdown: countdown));
  }

  void geToNew() {
    emit(CountdownTabNew());
  }
}
