import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/models/cal_event_modle.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_cal_repo.dart';

part 'show_events_state.dart';

class ShowEventsCubit extends Cubit<ShowEventsState> {
  ShowEventsCubit() : super(ShowEventsInitial());

  List<CalEvent> allEvents = [];

  Future<void> getAllEvents() async {
    try {
      emit(ShowEventsLoading());
      allEvents = await FirebaseCalRepo.getCalEvents();
      emit(ShowEventsLoaded(events: allEvents));
    } catch (e) {
      emit(ShowEventsFailed(errorMsg: e.toString()));
    }
  }
}
