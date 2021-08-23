import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_pal/data/models/subject_model.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_auth_repo.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_content_repo.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_module_repo.dart';

class FirebaseSubjectRepo {
  static Future<void> addSubjects({
    required List<Subject> subjectList,
  }) async {
    try {
      CollectionReference subjects = FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuthRepo.currentUid())
          .collection("subjects");
      subjectList.forEach((subject) async {
        await subjects.doc(subject.id).set({
          "id": subject.id,
          "name": subject.name,
        });
      });
    } catch (e) {
      throw e;
    }
  }

  static Future<List<Subject>> getSubjects() async {
    try {
      List<Subject> subjectList = [];
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuthRepo.currentUid())
          .collection("subjects")
          .get();
      snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        subjectList.add(Subject(id: data["id"], name: data["name"]));
      }).toList();
      return subjectList;
    } catch (e) {
      throw e;
    }
  }

  static Future<Subject> getSubjectById({required String subjectId}) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuthRepo.currentUid())
          .collection('subjects')
          .doc(subjectId)
          .get();
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;
      return Subject(id: data['id'], name: data['name']);
    } catch (e) {
      throw e;
    }
  }

  static Future<void> deleteSubjectById({required String subjectId}) async {
    try {
      DocumentReference reference = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuthRepo.currentUid())
          .collection('subjects')
          .doc(subjectId);
      await reference.delete();
      await FirebaseModuleRepo.deleteMudulesForSub(subjectId: subjectId);
      await FirebaseContentRepo.deleteFireConsForSub(subjectId: subjectId);
    } catch (e) {
      throw e;
    }
  }
}
