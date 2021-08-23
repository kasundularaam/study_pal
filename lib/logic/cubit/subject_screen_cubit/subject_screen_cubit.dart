import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/http/http_requests.dart';
import 'package:study_pal/data/models/module_model.dart';

part 'subject_screen_state.dart';

class SubjectScreenCubit extends Cubit<SubjectScreenState> {
  SubjectScreenCubit() : super(SubjectScreenInitial());

  List<Module> moduleList = [];

  Future<void> loadModules({required String subjectId}) async {
    try {
      emit(SubjectScreenLoading());
      moduleList = await HttpRequests.getModules(subjectId: subjectId);
      if (moduleList.isNotEmpty) {
        emit(SubjectScreenLoaded(moduleList: moduleList));
      } else {
        emit(SubjectScreenNoResult(message: "No Results Found"));
      }
    } catch (e) {
      emit(SubjectScreenFailed(errorMsg: e.toString()));
    }
  }

  void loadSearchList({required String searchTxt}) {
    try {
      emit(SubjectScreenLoading());
      List<Module> searchList = [];
      moduleList.forEach((module) {
        if (module.moduleName.toLowerCase().contains(searchTxt.toLowerCase())) {
          searchList.add(module);
        }
      });
      if (searchList.isNotEmpty) {
        emit(SubjectScreenLoaded(moduleList: searchList));
      } else {
        emit(SubjectScreenNoResult(message: "No Results Found"));
      }
    } catch (e) {
      emit(SubjectScreenFailed(errorMsg: e.toString()));
    }
  }
}
