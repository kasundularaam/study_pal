import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/models/add_mod_eve_cal_cu_model.dart';
import 'package:study_pal/data/repositories/calandar_repo.dart';

part 'add_mod_eve_cal_state.dart';

class AddModEveCalCubit extends Cubit<AddModEveCalState> {
  AddModEveCalCubit() : super(AddModEveCalInitial());

  Future<void> addModEveToCal(
      {required AddModEveCalCuMod addModEveCalCuMod,
      required int count}) async {
    try {
      DateTime selectedDateTime = DateTime(
        addModEveCalCuMod.date.year,
        addModEveCalCuMod.date.month,
        addModEveCalCuMod.date.day,
        addModEveCalCuMod.time.hour,
        addModEveCalCuMod.time.minute,
      );
      List<Event> events = [];
      for (int i = 0; i < count; i++) {
        DateTime eveStartTime = selectedDateTime.add(Duration(days: (7 * i)));
        DateTime eventEndTime = eveStartTime.add(Duration(hours: 2));
        Event event = new Event();
        EventDateTime start = new EventDateTime();
        start.dateTime = eveStartTime;
        start.timeZone = "GMT+5:30";
        event.start = start;

        EventDateTime end = new EventDateTime();
        end.timeZone = "GMT+5:30";
        end.dateTime = eventEndTime;
        event.end = end;
        int weekInt = i + 1;
        event.summary =
            "${addModEveCalCuMod.subjectName} > ${addModEveCalCuMod.moduleName} | week $weekInt";
        events.add(event);
      }
      await CalandarRepo.addModEveToCal(
          events: events,
          addModEveCalCuMod: addModEveCalCuMod,
          selectedDateTime: selectedDateTime);

      emit(AddModEveCalSucceed());
    } catch (e) {
      emit(AddModEveCalFailed(errorMsg: e.toString()));
    }
  }
}
