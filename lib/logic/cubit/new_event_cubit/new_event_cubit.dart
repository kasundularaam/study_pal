import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:study_pal/data/models/cal_event_modle.dart';
import 'package:study_pal/data/repositories/calandar_repo.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_cal_repo.dart';

part 'new_event_state.dart';

class NewEventCubit extends Cubit<NewEventState> {
  NewEventCubit() : super(NewEventInitial());

  Future<void> addNewEvent(
      {required DateTime date,
      required TimeOfDay time,
      required String title}) async {
    try {
      DateTime startTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      DateTime endTime = startTime.add(Duration(hours: 2));
      Event event = new Event();
      EventDateTime start = new EventDateTime();
      start.dateTime = startTime;
      start.timeZone = "GMT+5:30";
      event.start = start;
      event.summary = title;

      EventDateTime end = new EventDateTime();
      end.timeZone = "GMT+5:30";
      end.dateTime = endTime;
      event.end = end;

      String? eventId = await CalandarRepo.addEventForAContent(event: event);
      if (eventId != null) {
        await FirebaseCalRepo.addEventToCal(
          calEvent: CalEvent(
            id: eventId,
            title: title,
            time: startTime.millisecondsSinceEpoch,
            type: "custom",
            subjectId: "",
            subjectName: "",
            moduleId: "",
            moduleName: "",
            contentId: "",
            contentName: "",
          ),
        );
        emit(NewEventSucceed());
      } else {
        emit(
          NewEventFailed(errorMsg: "Unable to add event in google calendar"),
        );
      }
    } catch (e) {
      emit(NewEventFailed(errorMsg: e.toString()));
    }
  }
}
