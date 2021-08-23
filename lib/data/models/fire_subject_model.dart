import 'dart:convert';

class FireSubject {
  final String subjectId;
  final String subjectName;
  final String subjectColor;
  FireSubject({
    required this.subjectId,
    required this.subjectName,
    required this.subjectColor,
  });

  FireSubject copyWith({
    String? subjectId,
    String? subjectName,
    String? subjectColor,
  }) {
    return FireSubject(
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
      subjectColor: subjectColor ?? this.subjectColor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subjectId': subjectId,
      'subjectName': subjectName,
      'subjectColor': subjectColor,
    };
  }

  factory FireSubject.fromMap(Map<String, dynamic> map) {
    return FireSubject(
      subjectId: map['subjectId'],
      subjectName: map['subjectName'],
      subjectColor: map['subjectColor'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FireSubject.fromJson(String source) =>
      FireSubject.fromMap(json.decode(source));

  @override
  String toString() =>
      'FireSubject(subjectId: $subjectId, subjectName: $subjectName, subjectColor: $subjectColor)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FireSubject &&
        other.subjectId == subjectId &&
        other.subjectName == subjectName &&
        other.subjectColor == subjectColor;
  }

  @override
  int get hashCode =>
      subjectId.hashCode ^ subjectName.hashCode ^ subjectColor.hashCode;
}
