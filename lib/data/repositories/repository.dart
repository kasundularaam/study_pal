import 'package:study_pal/data/data_providers/data_provider.dart';
import 'package:study_pal/data/http/http_requests.dart';
import 'package:study_pal/data/models/content_model.dart';
import 'package:study_pal/data/models/module_model.dart';
import 'package:study_pal/data/models/question_model.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Repository {
  static Future<List<Subject>> getSubjectById(
      {required List<String> subjectIds}) async {
    try {
      List<Subject> subjects = await HttpRequests.getSubjects();
      List<Subject> subsToAdd = [];
      subjects.forEach((sub) {
        if (subjectIds.contains(sub.id)) {
          subsToAdd.add(sub);
        }
      });
      return subsToAdd;
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getModuleCountBySubId({required String subjectId}) async {
    try {
      List<Module> moduleList =
          await HttpRequests.getModules(subjectId: subjectId);
      return moduleList.length;
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getContentCountByModId({required String moduleId}) async {
    try {
      List<Content> list = await HttpRequests.getContents(moduleId: moduleId);
      return list.length;
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getQuizCountByModId({required String moduleId}) async {
    try {
      List<Question> list = await HttpRequests.getQuestions(moduleId: moduleId);
      return list.length;
    } catch (e) {
      throw e;
    }
  }

  static void downloadPdf({required String path}) {
    try {
      launch(DataProvider.pdfDownloadLink(path: path));
    } catch (e) {
      throw e;
    }
  }

  static Future<Content?> getContent(
      {required String moduleId, required String contentId}) async {
    try {
      Content? content;
      List<Content> contentList =
          await HttpRequests.getContents(moduleId: moduleId);
      contentList.forEach((contentFromList) {
        if (contentFromList.id == contentId) {
          content = contentFromList;
        }
      });
      if (content != null) {
        return content;
      } else {
        throw "No Result Found";
      }
    } catch (e) {
      throw e;
    }
  }
}
