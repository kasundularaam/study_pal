import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_pal/data/models/fire_module_model.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_auth_repo.dart';

class FirebaseModuleRepo {
  static Future<void> addFireModule({required FireModule fireModule}) async {
    try {
      CollectionReference reference = FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuthRepo.currentUid())
          .collection("modules");
      reference.doc(fireModule.moduleId).set({
        'moduleId': fireModule.moduleId,
        'moduleName': fireModule.moduleName,
        'isCompleted': fireModule.isCompleted,
        'subjectId': fireModule.subjectId,
        'subjectName': fireModule.subjectName,
      });
    } catch (e) {
      throw e;
    }
  }

  static Future<List<FireModule>> getFiremodules(
      {required String subjectId}) async {
    try {
      List<FireModule> moduleList = [];
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuthRepo.currentUid())
          .collection("modules")
          .where('subjectId', isEqualTo: subjectId)
          .get();
      snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        moduleList.add(
          FireModule(
            moduleId: data['moduleId'],
            moduleName: data['moduleName'],
            isCompleted: data['isCompleted'],
            subjectId: data['subjectId'],
            subjectName: data['subjectName'],
          ),
        );
      }).toList();
      return moduleList;
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getFireModuleCount({required String subjectId}) async {
    try {
      List<FireModule> moduleList = await getFiremodules(subjectId: subjectId);
      return moduleList.length;
    } catch (e) {
      throw e;
    }
  }

  static Future<void> deleteMudulesForSub({required String subjectId}) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuthRepo.currentUid())
          .collection("modules")
          .where('subjectId', isEqualTo: subjectId)
          .get();
      snapshot.docs.forEach((doc) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuthRepo.currentUid())
            .collection('modules')
            .doc(doc.id)
            .delete();
      });
    } catch (e) {
      throw e;
    }
  }
}
