import 'dart:convert';

class FireQuize {
  final String quizId;
  final String subjectId;
  final String moduleId;
  final bool isCorrect;
  FireQuize({
    required this.quizId,
    required this.subjectId,
    required this.moduleId,
    required this.isCorrect,
  });

  FireQuize copyWith({
    String? quizId,
    String? subjectId,
    String? moduleId,
    bool? isCorrect,
  }) {
    return FireQuize(
      quizId: quizId ?? this.quizId,
      subjectId: subjectId ?? this.subjectId,
      moduleId: moduleId ?? this.moduleId,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quizId': quizId,
      'subjectId': subjectId,
      'moduleId': moduleId,
      'isCorrect': isCorrect,
    };
  }

  factory FireQuize.fromMap(Map<String, dynamic> map) {
    return FireQuize(
      quizId: map['quizId'],
      subjectId: map['subjectId'],
      moduleId: map['moduleId'],
      isCorrect: map['isCorrect'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FireQuize.fromJson(String source) =>
      FireQuize.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FireQuize(quizId: $quizId, subjectId: $subjectId, moduleId: $moduleId, isCorrect: $isCorrect)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FireQuize &&
        other.quizId == quizId &&
        other.subjectId == subjectId &&
        other.moduleId == moduleId &&
        other.isCorrect == isCorrect;
  }

  @override
  int get hashCode {
    return quizId.hashCode ^
        subjectId.hashCode ^
        moduleId.hashCode ^
        isCorrect.hashCode;
  }
}
