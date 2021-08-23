import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_pal/core/constants/shared_prefs_keys.dart';
import 'package:study_pal/core/notifications/notification_service.dart';
import 'package:study_pal/core/screen_arguments/content_screen_args.dart';
import 'package:study_pal/core/screen_arguments/end_tab_args.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerInitial(initCounter: "00:00:00"));

  int counter = 0;
  String timeString = "00:00:00";
  String hoursStr = "";
  String minutesStr = "";
  String secondsStr = "";
  int startTimestamp = 0;
  int endTimestamp = 0;
  Timer? _myTimer;
  Duration timerInterval = Duration(seconds: 1);

  Future<void> startTimer(
      {required String notifMsg, required ContentScreenArgs args}) async {
    startTimestamp = DateTime.now().millisecondsSinceEpoch;
    emit(TimerStarted(startedCounter: "00:00:00"));
    await setShrPrefVlues(args: args);
    NotificationService.showNotification(message: notifMsg);
    _myTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      counter++;
      hoursStr =
          ((counter / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
      minutesStr = ((counter / 60) % 60).floor().toString().padLeft(2, '0');
      secondsStr = (counter % 60).floor().toString().padLeft(2, '0');
      timeString = "$hoursStr" ":" "$minutesStr" ":" "$secondsStr";
      emit(TimerRunning(timeCounter: timeString));
    });
  }

  void backToWork({required startTimeStampSp}) {
    emit(TimerStarted(startedCounter: "00:00:00"));
    startTimestamp = startTimeStampSp;
    DateTime timeNow = DateTime.now();
    DateTime startTimeSt =
        DateTime.fromMillisecondsSinceEpoch(startTimeStampSp);
    counter = timeNow.difference(startTimeSt).inSeconds;
    _myTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      counter++;
      hoursStr =
          ((counter / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
      minutesStr = ((counter / 60) % 60).floor().toString().padLeft(2, '0');
      secondsStr = (counter % 60).floor().toString().padLeft(2, '0');
      timeString = "$hoursStr" ":" "$minutesStr" ":" "$secondsStr";
      emit(TimerRunning(timeCounter: timeString));
    });
  }

  Future<void> endTimer({required ContentScreenArgs contentScreenArgs}) async {
    if (_myTimer != null) {
      endTimestamp = DateTime.now().millisecondsSinceEpoch;
      _myTimer!.cancel();
      _myTimer = null;
      emit(
        TimerEnded(
          args: EndTabArgs(
            contentScreenArgs: contentScreenArgs,
            clockValue: timeString,
            startTimestamp: startTimestamp,
            endTimestamp: endTimestamp,
            counter: counter,
          ),
        ),
      );

      NotificationService.clancelNotification();
      await removeShrPrefVlues();
    }
  }

  Future<void> setShrPrefVlues({required ContentScreenArgs args}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(SharedPrefsKeys.isOnWorkingKey, true);
    preferences.setInt(SharedPrefsKeys.startTimeStampKey, startTimestamp);
    preferences.setString(SharedPrefsKeys.contentIdKey, args.contentId);
    preferences.setString(SharedPrefsKeys.contentNameKey, args.contentName);
    preferences.setString(SharedPrefsKeys.moduleIdKey, args.moduleId);
    preferences.setString(SharedPrefsKeys.moduleNameKey, args.moduleName);
    preferences.setString(SharedPrefsKeys.subjectIdKey, args.subjectId);
    preferences.setString(SharedPrefsKeys.subjectNameKey, args.subjectName);
  }

  Future<void> removeShrPrefVlues() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(SharedPrefsKeys.isOnWorkingKey, false);
    preferences.remove(SharedPrefsKeys.startTimeStampKey);
    preferences.remove(SharedPrefsKeys.contentIdKey);
    preferences.remove(SharedPrefsKeys.contentNameKey);
    preferences.remove(SharedPrefsKeys.moduleIdKey);
    preferences.remove(SharedPrefsKeys.moduleNameKey);
    preferences.remove(SharedPrefsKeys.subjectIdKey);
    preferences.remove(SharedPrefsKeys.subjectNameKey);
  }

  void cancelTimer() {
    if (_myTimer != null) {
      _myTimer!.cancel();
      _myTimer = null;
    }
  }
}
