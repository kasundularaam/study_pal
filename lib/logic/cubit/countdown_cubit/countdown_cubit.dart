import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'countdown_state.dart';

class CountdownCubit extends Cubit<CountdownState> {
  CountdownCubit() : super(CountdownInitial());

  void runCounter({required int examTimeStmp}) {
    DateTime examTime = DateTime.fromMillisecondsSinceEpoch(examTimeStmp);
    DateTime now = DateTime.now();
    int duration = examTime.difference(now).inSeconds;
    Timer.periodic(Duration(seconds: 1), (timer) {
      duration--;
      String daysStr =
          (duration / (24 * (60 * 60))).floor().toString().padLeft(2, '0');
      String hoursStr =
          ((duration / (60 * 60)) % 24).floor().toString().padLeft(2, '0');
      String minutesStr =
          ((duration / 60) % 60).floor().toString().padLeft(2, '0');
      String secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
      if (duration >= 0) {
        emit(CountdownRunning(
            daysStr: daysStr,
            hoursStr: hoursStr,
            minutesStr: minutesStr,
            secondsStr: secondsStr));
      } else {
        emit(CountdownEnded());
      }
    });
  }
}
