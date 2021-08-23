import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/models/content_model.dart';
import 'package:study_pal/data/repositories/repository.dart';

part 'download_pdf_state.dart';

class DownloadPdfCubit extends Cubit<DownloadPdfState> {
  DownloadPdfCubit() : super(DownloadPdfInitial());

  Future<void> downloadPdf(
      {required String moduleId, required String contentId}) async {
    try {
      emit(DownloadPdfLoading());
      Content? content =
          await Repository.getContent(moduleId: moduleId, contentId: contentId);
      Repository.downloadPdf(path: content!.contentLink);
      emit(DownloadPdfInitial());
    } catch (e) {
      emit(DownloadPdfFailed(errorMsg: e.toString()));
    }
  }
}
