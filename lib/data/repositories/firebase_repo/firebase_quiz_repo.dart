import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_pal/data/models/fire_quiz.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_auth_repo.dart';

class FirebaseQuizRepo {
  static CollectionReference reference = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuthRepo.currentUid())
      .collection("quizes");

  static Future<void> uploadQuizes(
      {required List<FireQuize> fireQuizes}) async {
    try {
      fireQuizes.forEach((fireQuize) async {
        await reference.doc(fireQuize.quizId).set(fireQuize.toMap());
      });
    } catch (e) {
      throw e;
    }
  }

  static Future<List<FireQuize>> getFireQuizes() async {
    try {
      List<FireQuize> fireQuizes = [];
      QuerySnapshot snapshot = await reference.get();
      snapshot.docs.map((doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        fireQuizes.add(FireQuize.fromMap(map));
      }).toList();
      return fireQuizes;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<FireQuize>> getFireQuizesBySub(
      {required String subjectId}) async {
    try {
      List<FireQuize> fireQuizes = [];
      QuerySnapshot snapshot =
          await reference.where("subjectId", isEqualTo: subjectId).get();
      snapshot.docs.map((doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        fireQuizes.add(FireQuize.fromMap(map));
      }).toList();
      return fireQuizes;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<FireQuize>> getFireQuizByMod(
      {required String subjectId, required String moduleId}) async {
    try {
      List<FireQuize> fireQuizesByMod = [];
      List<FireQuize> fireQuizesBySub =
          await getFireQuizesBySub(subjectId: subjectId);
      fireQuizesBySub.forEach((fireQuize) {
        if (fireQuize.moduleId == moduleId) {
          fireQuizesByMod.add(fireQuize);
        }
      });
      return fireQuizesByMod;
    } catch (e) {
      throw e;
    }
  }
}
