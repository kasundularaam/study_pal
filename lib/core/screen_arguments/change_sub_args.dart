import 'package:study_pal/data/models/subject_model.dart';

class ChangeSubScrnArgs {
  final List<Subject> fireSubjects;
  final List<Subject> subjects;
  ChangeSubScrnArgs({
    required this.fireSubjects,
    required this.subjects,
  });
}
