import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_pal/data/models/fire_user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:study_pal/data/value%20validator/auth_value_validator.dart';

class FirebaseAuthRepo {
  static DocumentReference reference = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuthRepo.currentUid());

  static String imageFilePath = "images/${currentUid()}/profile.png";

  static storage.Reference profilePicRef =
      storage.FirebaseStorage.instance.ref(imageFilePath);

  static Future<void> loginWithEmailAndpswd(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided for that user.';
      }
    }
  }

  static Future<void> signUpNewUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await addUserToFireStore(
            fireUser: FireUser(
                uid: currentUser.uid,
                name: name,
                email: email,
                profilePic: "null"));
      } else {
        throw "canot add user to database. user does not exist";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
    } catch (e) {
      throw e;
    }
  }

  static bool checkUserStatus() {
    try {
      User? currenUser = FirebaseAuth.instance.currentUser;
      if (currenUser != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<void> logOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw e;
    }
  }

  static Future<void> addUserToFireStore({
    required FireUser fireUser,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(fireUser.uid)
          .set(fireUser.toMap());
    } catch (e) {
      throw e;
    }
  }

  static String currentUid() {
    try {
      User? currenUser = FirebaseAuth.instance.currentUser;
      if (currenUser != null) {
        return currenUser.uid;
      } else {
        throw "user not available";
      }
    } catch (e) {
      throw e;
    }
  }

  static String currentEmail() {
    try {
      User? currenUser = FirebaseAuth.instance.currentUser;
      if (currenUser != null) {
        return currenUser.email!;
      } else {
        throw "user not available";
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<FireUser> getUserDetails() async {
    try {
      DocumentSnapshot snapshot = await reference.get();
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;
      return FireUser.fromMap(data);
    } catch (e) {
      throw e;
    }
  }

  static Future<void> updateUserName({required String newName}) async {
    try {
      if (newName.isNotEmpty) {
        await reference.update({'name': newName});
      } else {
        throw "Name is empty!";
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<void> changePassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      if (currentPassword.isNotEmpty && newPassword.isNotEmpty) {
        await loginWithEmailAndpswd(
            email: currentEmail(), password: currentPassword);
        await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
      } else {
        throw "Some fields are empty!";
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<void> resetPassword(String email) async {
    try {
      String validatedEmail = ValueValidator.validateEmail(email: email);

      if (validatedEmail == ValueValidator.validEmail) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      } else {
        throw validatedEmail;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<void> uploadProfilePic({required File imageFile}) async {
    try {
      await profilePicRef.putFile(imageFile);
      String downloadUrl = await profilePicRef.getDownloadURL();
      await reference.update({"profilePic": downloadUrl});
    } catch (e) {
      throw e;
    }
  }
}
