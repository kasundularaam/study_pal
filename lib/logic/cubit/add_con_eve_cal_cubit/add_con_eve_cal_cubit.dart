import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/models/add_con_eve_cal_cu_model.dart';
import 'package:study_pal/data/models/cal_event_modle.dart';
import 'package:study_pal/data/repositories/calandar_repo.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_cal_repo.dart';

part 'add_con_eve_cal_state.dart';

class AddConEventToCalCubit extends Cubit<AddConEventToCalState> {
  AddConEventToCalCubit() : super(AddConEventToCalInitial());

  Future<void> addConEventToCal(
      {required AddConEvCalCuMod addEvCalCuMod}) async {
    try {
      emit(AddConEventToCalLoading());
      DateTime startTime = DateTime(
        addEvCalCuMod.date.year,
        addEvCalCuMod.date.month,
        addEvCalCuMod.date.day,
        addEvCalCuMod.time.hour,
        addEvCalCuMod.time.minute,
      );
      DateTime endTime = startTime.add(Duration(hours: 2));
      Event event = new Event();
      EventDateTime start = new EventDateTime();
      start.dateTime = startTime;
      start.timeZone = "GMT+5:30";
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.timeZone = "GMT+5:30";
      end.dateTime = endTime;
      event.end = end;
      String eventTitle =
          "${addEvCalCuMod.subjectName} > ${addEvCalCuMod.moduleName} > ${addEvCalCuMod.contentName}";
      event.summary = eventTitle;
      String? eventId = await CalandarRepo.addEventForAContent(event: event);
      if (eventId != null) {
        await FirebaseCalRepo.addEventToCal(
          calEvent: CalEvent(
            id: eventId,
            title: eventTitle,
            time: startTime.millisecondsSinceEpoch,
            type: "content",
            subjectId: addEvCalCuMod.subjectId,
            subjectName: addEvCalCuMod.subjectName,
            moduleId: addEvCalCuMod.moduleId,
            moduleName: addEvCalCuMod.moduleName,
            contentId: addEvCalCuMod.contentId,
            contentName: addEvCalCuMod.contentName,
          ),
        );
        emit(AddConEventToCalSucceed());
      } else {
        emit(AddConEventToCalFailed(
            errorMsg: "Unable to add event in google calendar"));
      }
    } catch (e) {
      emit(AddConEventToCalFailed(errorMsg: e.toString()));
    }
  }
}
