import 'dart:convert';

class FireContent {
  final int startTimestamp;
  final int endTimestamp;
  final int counter;
  final String contentId;
  final String contentName;
  final String subjectName;
  final String subjectId;
  final String moduleName;
  final String moduleId;
  final bool isCompleted;
  FireContent({
    required this.startTimestamp,
    required this.endTimestamp,
    required this.counter,
    required this.contentId,
    required this.contentName,
    required this.subjectName,
    required this.subjectId,
    required this.moduleName,
    required this.moduleId,
    required this.isCompleted,
  });

  FireContent copyWith({
    int? startTimestamp,
    int? endTimestamp,
    int? counter,
    String? contentId,
    String? contentName,
    String? subjectName,
    String? subjectId,
    String? moduleName,
    String? moduleId,
    bool? isCompleted,
  }) {
    return FireContent(
      startTimestamp: startTimestamp ?? this.startTimestamp,
      endTimestamp: endTimestamp ?? this.endTimestamp,
      counter: counter ?? this.counter,
      contentId: contentId ?? this.contentId,
      contentName: contentName ?? this.contentName,
      subjectName: subjectName ?? this.subjectName,
      subjectId: subjectId ?? this.subjectId,
      moduleName: moduleName ?? this.moduleName,
      moduleId: moduleId ?? this.moduleId,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startTimestamp': startTimestamp,
      'endTimestamp': endTimestamp,
      'counter': counter,
      'contentId': contentId,
      'contentName': contentName,
      'subjectName': subjectName,
      'subjectId': subjectId,
      'moduleName': moduleName,
      'moduleId': moduleId,
      'isCompleted': isCompleted,
    };
  }

  factory FireContent.fromMap(Map<String, dynamic> map) {
    return FireContent(
      startTimestamp: map['startTimestamp'],
      endTimestamp: map['endTimestamp'],
      counter: map['counter'],
      contentId: map['contentId'],
      contentName: map['contentName'],
      subjectName: map['subjectName'],
      subjectId: map['subjectId'],
      moduleName: map['moduleName'],
      moduleId: map['moduleId'],
      isCompleted: map['isCompleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FireContent.fromJson(String source) =>
      FireContent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FireContent(startTimestamp: $startTimestamp, endTimestamp: $endTimestamp, counter: $counter, contentId: $contentId, contentName: $contentName, subjectName: $subjectName, subjectId: $subjectId, moduleName: $moduleName, moduleId: $moduleId, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FireContent &&
        other.startTimestamp == startTimestamp &&
        other.endTimestamp == endTimestamp &&
        other.counter == counter &&
        other.contentId == contentId &&
        other.contentName == contentName &&
        other.subjectName == subjectName &&
        other.subjectId == subjectId &&
        other.moduleName == moduleName &&
        other.moduleId == moduleId &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return startTimestamp.hashCode ^
        endTimestamp.hashCode ^
        counter.hashCode ^
        contentId.hashCode ^
        contentName.hashCode ^
        subjectName.hashCode ^
        subjectId.hashCode ^
        moduleName.hashCode ^
        moduleId.hashCode ^
        isCompleted.hashCode;
  }
}
