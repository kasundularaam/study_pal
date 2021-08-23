class DataProvider {
  static String subjectUrl() {
    return "http://critssl.com/studyPlanner/subject.php";
  }

  static String moduleUrl({required String subjectId}) {
    return "http://critssl.com/studyPlanner/module.php?subject=$subjectId";
  }

  static String contentUrl({required String moduleId}) {
    return "http://critssl.com/studyPlanner/content.php?module=$moduleId";
  }

  static String questionUrl({required moduleId}) {
    return "http://critssl.com/studyPlanner/question.php?module=$moduleId";
  }

  static String contentCountBySubUrl({required subjectId}) {
    return "http://critssl.com/studyPlanner/content.php?subject=$subjectId";
  }

  static String questionCountBySubUrl({required subjectId}) {
    return "http://critssl.com/studyPlanner/question.php?subject=$subjectId";
  }

  static String pdfDownloadLink({required String path}) {
    return "http://critssl.com/studyPlanner/$path";
  }
}
