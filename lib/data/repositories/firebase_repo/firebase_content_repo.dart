import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:study_pal/data/models/fire_content.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_auth_repo.dart';

class FirebaseContentRepo {
  static Future<List<FireContent>> getFireContentsBySub(
      {required String subjectId}) async {
    try {
      List<FireContent> fireContentList = [];
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuthRepo.currentUid())
          .collection("contents")
          .where('subjectId', isEqualTo: subjectId)
          .get();
      snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        fireContentList.add(FireContent(
            startTimestamp: data['startTimestamp'],
            endTimestamp: data['endTimestamp'],
            counter: data['counter'],
            contentId: data['contentId'],
            contentName: data['contentName'],
            subjectName: data['subjectName'],
            subjectId: data['subjectId'],
            moduleName: data['moduleName'],
            moduleId: data['moduleId'],
            isCompleted: data['isCompleted']));
      }).toList();
      return fireContentList;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<FireContent>> getCompletedContentsBySub(
      {required String subjectId}) async {
    try {
      List<FireContent> filteredList = [];
      List<FireContent> fireContentList =
          await getFireContentsBySub(subjectId: subjectId);
      fireContentList.forEach((fireContent) {
        if (fireContent.isCompleted) {
          filteredList.add(fireContent);
        }
      });
      return filteredList;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<FireContent>> getCleanCompletedContentsBySub(
      {required String subjectId}) async {
    try {
      List<FireContent> cleanedList = [];
      List<String> idList = [];
      List<FireContent> filteredList =
          await getCompletedContentsBySub(subjectId: subjectId);
      filteredList.forEach((fireContent) {
        if (!idList.contains(fireContent.contentId)) {
          idList.add(fireContent.contentId);
          cleanedList.add(fireContent);
        }
      });
      return cleanedList;
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getCleanedContentsCountBySub(
      {required String subjectId}) async {
    try {
      List<FireContent> cleanedList =
          await getCleanCompletedContentsBySub(subjectId: subjectId);
      return cleanedList.length;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<FireContent>> getCleanedContentsForSubMod(
      {required String subjectId, required String moduleId}) async {
    try {
      List<FireContent> filteredList = [];
      List<FireContent> cleanedList =
          await getCleanCompletedContentsBySub(subjectId: subjectId);
      cleanedList.forEach((fireContent) {
        if (fireContent.moduleId == moduleId) {
          filteredList.add(fireContent);
        }
      });
      return filteredList;
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getCleanedContentsCountForSubMod(
      {required String subjectId, required String moduleId}) async {
    try {
      List<FireContent> filteredList = await getCleanedContentsForSubMod(
          subjectId: subjectId, moduleId: moduleId);
      return filteredList.length;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<FireContent>> getFireContents() async {
    try {
      List<FireContent> allContents = [];
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuthRepo.currentUid())
          .collection("contents")
          .orderBy('startTimestamp', descending: true)
          .get();
      snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        allContents.add(FireContent(
            startTimestamp: data['startTimestamp'],
            endTimestamp: data['endTimestamp'],
            counter: data['counter'],
            contentId: data['contentId'],
            contentName: data['contentName'],
            subjectName: data['subjectName'],
            subjectId: data['subjectId'],
            moduleName: data['moduleName'],
            moduleId: data['moduleId'],
            isCompleted: data['isCompleted']));
      }).toList();
      return allContents;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<FireContent>> getFireContentsForToday() async {
    try {
      List<FireContent> todayFireContents = [];
      List<FireContent> allFireContents = await getFireContents();
      DateFormat format = DateFormat("dd.MM.yyyy");
      int now = DateTime.now().millisecondsSinceEpoch;
      String formattedNow =
          format.format(DateTime.fromMillisecondsSinceEpoch(now));
      allFireContents.forEach((fireContent) {
        String formattedFc = format.format(
            DateTime.fromMillisecondsSinceEpoch(fireContent.startTimestamp));
        if (formattedFc == formattedNow) {
          todayFireContents.add(fireContent);
        }
      });
      return todayFireContents;
    } catch (e) {
      throw e;
    }
  }

  static Future<void> deleteFireConsForSub({required String subjectId}) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuthRepo.currentUid())
          .collection('contents')
          .where('subjectId', isEqualTo: subjectId)
          .get();
      querySnapshot.docs.forEach((doc) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuthRepo.currentUid())
            .collection('contents')
            .doc(doc.id)
            .delete();
      });
    } catch (e) {
      throw e;
    }
  }
}
