import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:study_pal/data/data_providers/data_provider.dart';
import 'package:study_pal/data/models/content_model.dart';
import 'package:study_pal/data/models/module_model.dart';
import 'package:study_pal/data/models/question_model.dart';
import 'package:study_pal/data/models/subject_model.dart';

class HttpRequests {
  //Support funtions
  static List<Subject> parseSubject(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Subject>(
          (json) => Subject.fromJson(json),
        )
        .toList();
  }

  static List<Module> parseModule(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Module>(
          (json) => Module.fromJson(json),
        )
        .toList();
  }

  static List<Content> parseContent(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Content>(
          (json) => Content.fromJson(json),
        )
        .toList();
  }

  static List<Question> parseQuestion(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Question>(
          (json) => Question.fromJson(json),
        )
        .toList();
  }

  // backend functions

  static Future<List<Subject>> getSubjects() async {
    try {
      final response = await http.get(
        Uri.parse(
          DataProvider.subjectUrl(),
        ),
      );
      if (response.statusCode == 200) {
        List<Subject> subjectList = parseSubject(response.body);
        return subjectList;
      } else {
        throw '${response.statusCode}';
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<List<Module>> getModules({required String subjectId}) async {
    try {
      final response = await http.get(
        Uri.parse(
          DataProvider.moduleUrl(subjectId: subjectId),
        ),
      );
      if (response.statusCode == 200) {
        List<Module> moduleList = parseModule(response.body);
        return moduleList;
      } else {
        throw '${response.statusCode}';
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<List<Content>> getContents({required String moduleId}) async {
    try {
      final response = await http.get(
        Uri.parse(
          DataProvider.contentUrl(moduleId: moduleId),
        ),
      );
      if (response.statusCode == 200) {
        List<Content> contentList = parseContent(response.body);
        return contentList;
      } else {
        throw '${response.statusCode}';
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<List<Question>> getQuestions({required String moduleId}) async {
    try {
      final response = await http.get(
        Uri.parse(
          DataProvider.questionUrl(moduleId: moduleId),
        ),
      );
      if (response.statusCode == 200) {
        List<Question> questionList = parseQuestion(response.body);
        return questionList;
      } else {
        throw '${response.statusCode}';
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getContentCountBySub({required String subjectId}) async {
    try {
      int contentCount = 0;
      List<Module> modules = await getModules(subjectId: subjectId);
      for (var i = 0; i < modules.length; i++) {
        List<Content> contents = await getContents(moduleId: modules[i].id);
        contentCount = contentCount + contents.length;
      }
      return contentCount;
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getQuestionCountBySub({required String subjectId}) async {
    try {
      int quizCount = 0;
      List<Module> modules = await getModules(subjectId: subjectId);
      for (var i = 0; i < modules.length; i++) {
        List<Question> quizes = await getQuestions(moduleId: modules[i].id);
        quizCount = quizCount + quizes.length;
      }
      return quizCount;
    } catch (e) {
      throw e;
    }
  }
}
