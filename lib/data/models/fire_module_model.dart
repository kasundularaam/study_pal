import 'dart:convert';

class FireModule {
  final String moduleId;
  final String moduleName;
  final bool isCompleted;
  final String subjectId;
  final String subjectName;
  FireModule({
    required this.moduleId,
    required this.moduleName,
    required this.isCompleted,
    required this.subjectId,
    required this.subjectName,
  });

  FireModule copyWith({
    String? moduleId,
    String? moduleName,
    bool? isCompleted,
    String? subjectId,
    String? subjectName,
  }) {
    return FireModule(
      moduleId: moduleId ?? this.moduleId,
      moduleName: moduleName ?? this.moduleName,
      isCompleted: isCompleted ?? this.isCompleted,
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'moduleId': moduleId,
      'moduleName': moduleName,
      'isCompleted': isCompleted,
      'subjectId': subjectId,
      'subjectName': subjectName,
    };
  }

  factory FireModule.fromMap(Map<String, dynamic> map) {
    return FireModule(
      moduleId: map['moduleId'],
      moduleName: map['moduleName'],
      isCompleted: map['isCompleted'],
      subjectId: map['subjectId'],
      subjectName: map['subjectName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FireModule.fromJson(String source) =>
      FireModule.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FireModule(moduleId: $moduleId, moduleName: $moduleName, isCompleted: $isCompleted, subjectId: $subjectId, subjectName: $subjectName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FireModule &&
        other.moduleId == moduleId &&
        other.moduleName == moduleName &&
        other.isCompleted == isCompleted &&
        other.subjectId == subjectId &&
        other.subjectName == subjectName;
  }

  @override
  int get hashCode {
    return moduleId.hashCode ^
        moduleName.hashCode ^
        isCompleted.hashCode ^
        subjectId.hashCode ^
        subjectName.hashCode;
  }
}
