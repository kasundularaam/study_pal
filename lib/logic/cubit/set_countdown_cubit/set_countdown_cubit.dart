import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/models/countdown_model.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_countdown_repo.dart';

part 'set_countdown_state.dart';

class SetCountdownCubit extends Cubit<SetCountdownState> {
  SetCountdownCubit() : super(SetCountdownInitial());

  Future<void> setCoundown({
    String? countdownIdEdit,
    required DateTime? exmDate,
    required TimeOfDay? exmTime,
    required String examTitle,
  }) async {
    try {
      emit(SetCountdownLoading());
      if (exmDate != null && exmTime != null && examTitle.isNotEmpty) {
        String countdownId =
            countdownIdEdit ?? DateTime.now().millisecondsSinceEpoch.toString();
        int examTimeStamp = DateTime(exmDate.year, exmDate.month, exmDate.day,
                exmTime.hour, exmTime.minute)
            .millisecondsSinceEpoch;
        await FirebaseCountdownRepo.setCountdown(
          countdown: Countdown(
            countdownId: countdownId,
            examTitle: examTitle,
            examTimeStamp: examTimeStamp,
          ),
        );
        emit(SetCountdownSucceed());
      } else {
        emit(SetCountdownFaild(errorMsg: "some fields are empty!"));
      }
    } catch (e) {
      emit(SetCountdownFaild(errorMsg: e.toString()));
    }
  }
}
