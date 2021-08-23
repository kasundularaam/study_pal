import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/http/http_requests.dart';
import 'package:study_pal/data/models/content_model.dart';

part 'content_list_screen_state.dart';

class ContentListScreenCubit extends Cubit<ContentListScreenState> {
  ContentListScreenCubit() : super(ContentListScreenInitial());

  List<Content> contentList = [];

  Future<void> loadContentList({required String moduleId}) async {
    try {
      emit(ContentListScreenLoading());
      contentList = await HttpRequests.getContents(moduleId: moduleId);
      if (contentList.isNotEmpty) {
        emit(ContentListScreenLoaded(contentList: contentList));
      } else {
        emit(ContentListScreenNoResult(message: "No Results Found"));
      }
    } catch (e) {
      emit(ContentListScreenFailed(errorMsg: e.toString()));
    }
  }

  void loadSearchList({required String searchText}) {
    try {
      emit(ContentListScreenLoading());
      List<Content> searchList = [];
      contentList.forEach((content) {
        if (content.contentTitle
            .toLowerCase()
            .contains(searchText.toLowerCase())) {
          searchList.add(content);
        }
      });
      if (searchList.isNotEmpty) {
        emit(ContentListScreenLoaded(contentList: searchList));
      } else {
        emit(ContentListScreenNoResult(message: "No Results Found"));
      }
    } catch (e) {
      emit(ContentListScreenFailed(errorMsg: e.toString()));
    }
  }
}
