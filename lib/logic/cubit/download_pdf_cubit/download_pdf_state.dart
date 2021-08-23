part of 'download_pdf_cubit.dart';

@immutable
abstract class DownloadPdfState {}

class DownloadPdfInitial extends DownloadPdfState {}

class DownloadPdfLoading extends DownloadPdfState {}

class DownloadPdfFailed extends DownloadPdfState {
  final String errorMsg;
  DownloadPdfFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DownloadPdfFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'DownloadPdfFailed(errorMsg: $errorMsg)';
}
