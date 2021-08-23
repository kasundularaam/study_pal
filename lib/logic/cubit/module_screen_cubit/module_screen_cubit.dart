import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/http/http_requests.dart';
import 'package:study_pal/data/models/content_model.dart';

part 'module_screen_state.dart';

class ModuleScreenCubit extends Cubit<ModuleScreenState> {
  ModuleScreenCubit() : super(ModuleScreenInitial());

  Future<void> loadContentList({required String moduleId}) async {
    try {
      emit(ModuleScreenLoading());
      List<Content> contentList =
          await HttpRequests.getContents(moduleId: moduleId);
      if (contentList.isNotEmpty) {
        emit(ModuleScreenLoaded(contentList: contentList));
      } else {
        emit(ModuleScreenNoResult(message: "No Results Found"));
      }
    } catch (e) {
      emit(ModuleScreenFailed(errorMsg: e.toString()));
    }
  }
}
