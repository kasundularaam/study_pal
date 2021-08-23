import 'package:study_pal/data/models/subject_model.dart';

class ValueValidator {
  static const String validEmail = "validEmail";
  static const String validPassword = "validPassword";
  static const String validName = "validName";
  static const String invalidEmail =
      "Email you entered is not in valid format please check again";
  static const String invalidPassword =
      "Password must contains atleast 6 characters";
  static const String emptyPassword = "Password feild is empty";
  static const String emptyEmail = "Email feild is empty";
  static const String emptyName = "Name field is empty";
  static const String shortName = "Name you entered is too short";

  static String validateEmail({required String email}) {
    if (email.isNotEmpty) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      if (emailValid) {
        return validEmail;
      } else {
        return invalidEmail;
      }
    } else {
      return emptyEmail;
    }
  }

  static String validatePassword({required String password}) {
    if (password.isNotEmpty) {
      if (password.length > 5) {
        return validPassword;
      } else {
        return invalidPassword;
      }
    } else {
      return emptyPassword;
    }
  }

  static String validateName({required String name}) {
    if (name.isNotEmpty) {
      if (name.length > 3) {
        return validName;
      } else {
        return shortName;
      }
    } else {
      return emptyName;
    }
  }

  static List<Subject> validateSubjectList(
      {required List<Subject> subjectList}) {
    if (subjectList.isNotEmpty) {
      return subjectList;
    } else {
      throw "you have not selected any subject";
    }
  }
}
