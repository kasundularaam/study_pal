import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_pal/data/models/cal_event_modle.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_auth_repo.dart';

class FirebaseCalRepo {
  static CollectionReference reference = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuthRepo.currentUid())
      .collection("events");
  static Future<void> addEventToCal({required CalEvent calEvent}) async {
    try {
      reference.doc(calEvent.id).set({
        "id": calEvent.id,
        "title": calEvent.title,
        "time": calEvent.time,
        "type": calEvent.type,
        "subjectId": calEvent.subjectId,
        "subjectName": calEvent.subjectName,
        "moduleId": calEvent.moduleId,
        "moduleName": calEvent.moduleName,
        "contentId": calEvent.contentId,
        "contentName": calEvent.contentName,
      });
    } catch (e) {
      throw e;
    }
  }

  static Future<List<CalEvent>> getCalEvents() async {
    try {
      List<CalEvent> events = [];
      final int now = DateTime.now().millisecondsSinceEpoch;
      QuerySnapshot snapshot = await reference
          .where("time", isGreaterThanOrEqualTo: now)
          .orderBy("time", descending: false)
          .get();
      snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        events.add(
          CalEvent(
            id: data["id"],
            title: data["title"],
            time: data["time"],
            type: data["type"],
            subjectId: data["subjectId"],
            subjectName: data["subjectName"],
            moduleId: data["moduleId"],
            moduleName: data["moduleName"],
            contentId: data["contentId"],
            contentName: data["contentName"],
          ),
        );
      }).toList();
      return events;
    } catch (e) {
      throw e;
    }
  }

  static Future<void> deleteEvent({required String eventId}) async {
    try {
      await reference.doc(eventId).delete();
    } catch (e) {
      throw e;
    }
  }
}
