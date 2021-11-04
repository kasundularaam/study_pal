import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/models/cal_event_modle.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_cal_repo.dart';

part 'show_cal_events_state.dart';

class ShowCalEventsCubit extends Cubit<ShowCalEventsState> {
  ShowCalEventsCubit() : super(ShowCalEventsInitial());

  Future<void> loadEvents() async {
    try {
      emit(ShowCalEventsLoading());
      List<CalEvent> calEvents = await FirebaseCalRepo.getCalEvents();
      if (calEvents.isNotEmpty) {
        emit(ShowCalEventsLoaded(calEvents: calEvents));
      } else {
        emit(ShowCalEventsNoResult(message: "No Events"));
      }
    } catch (e) {
      emit(ShowCalEventsFailed(errorMsg: e.toString()));
    }
  }

  Future<void> searchEvents({required String searchText}) async {
    try {
      emit(ShowCalEventsLoading());
      String lCaseText = searchText.toLowerCase();
      List<CalEvent> calEvents = await FirebaseCalRepo.getCalEvents();
      List<CalEvent> filteredList = [];
      if (calEvents.isNotEmpty) {
        calEvents.forEach((singleEvent) {
          DateFormat dayFormat = DateFormat("dd");
          String day = dayFormat
              .format(DateTime.fromMillisecondsSinceEpoch(singleEvent.time));
          DateFormat monYrFormat = DateFormat("MMM");
          String month = monYrFormat
              .format(DateTime.fromMillisecondsSinceEpoch(singleEvent.time));
          if (singleEvent.title.toLowerCase().contains(lCaseText) ||
              day.toLowerCase().contains(lCaseText) ||
              month.toLowerCase().contains(lCaseText)) {
            filteredList.add(singleEvent);
          }
        });
        if (filteredList.isNotEmpty) {
          emit(ShowCalEventsLoaded(calEvents: filteredList));
        } else {
          emit(ShowCalEventsNoResult(message: "No Results found"));
        }
      } else {
        emit(ShowCalEventsNoResult(message: "No Results found"));
      }
    } catch (e) {
      emit(ShowCalEventsFailed(errorMsg: e.toString()));
    }
  }

  Future<void> deleteEvent({required String eventId}) async {
    try {
      await FirebaseCalRepo.deleteEvent(eventId: eventId);
      loadEvents();
    } catch (e) {
      emit(ShowCalEventsFailed(errorMsg: e.toString()));
      loadEvents();
    }
  }
}
