import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/http/http_requests.dart';
import 'package:study_pal/data/models/subject_model.dart';

part 'select_sub_list_state.dart';

class SelectSubListCubit extends Cubit<SelectSubListState> {
  SelectSubListCubit() : super(SelectSubListInitial());

  Future<void> loadSubjectList() async {
    try {
      emit(SelectSubjectLoading(loadingMsg: "loading subjects..."));
      List<Subject> subjectList = await HttpRequests.getSubjects();
      emit(SelectSubjectLoaded(subjectList: subjectList));
    } catch (e) {
      emit(SelectSubjectFailed(errorMsg: e.toString()));
    }
  }
}
