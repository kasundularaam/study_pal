import 'dart:convert';

class CalEvent {
  final String id;
  final String title;
  final int time;
  final String type;
  final String subjectId;
  final String subjectName;
  final String moduleId;
  final String moduleName;
  final String contentId;
  final String contentName;
  CalEvent({
    required this.id,
    required this.title,
    required this.time,
    required this.type,
    required this.subjectId,
    required this.subjectName,
    required this.moduleId,
    required this.moduleName,
    required this.contentId,
    required this.contentName,
  });

  CalEvent copyWith({
    String? id,
    String? title,
    int? time,
    String? type,
    String? subjectId,
    String? subjectName,
    String? moduleId,
    String? moduleName,
    String? contentId,
    String? contentName,
  }) {
    return CalEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      type: type ?? this.type,
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
      moduleId: moduleId ?? this.moduleId,
      moduleName: moduleName ?? this.moduleName,
      contentId: contentId ?? this.contentId,
      contentName: contentName ?? this.contentName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'type': type,
      'subjectId': subjectId,
      'subjectName': subjectName,
      'moduleId': moduleId,
      'moduleName': moduleName,
      'contentId': contentId,
      'contentName': contentName,
    };
  }

  factory CalEvent.fromMap(Map<String, dynamic> map) {
    return CalEvent(
      id: map['id'],
      title: map['title'],
      time: map['time'],
      type: map['type'],
      subjectId: map['subjectId'],
      subjectName: map['subjectName'],
      moduleId: map['moduleId'],
      moduleName: map['moduleName'],
      contentId: map['contentId'],
      contentName: map['contentName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CalEvent.fromJson(String source) =>
      CalEvent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CalEvent(id: $id, title: $title, time: $time, type: $type, subjectId: $subjectId, subjectName: $subjectName, moduleId: $moduleId, moduleName: $moduleName, contentId: $contentId, contentName: $contentName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalEvent &&
        other.id == id &&
        other.title == title &&
        other.time == time &&
        other.type == type &&
        other.subjectId == subjectId &&
        other.subjectName == subjectName &&
        other.moduleId == moduleId &&
        other.moduleName == moduleName &&
        other.contentId == contentId &&
        other.contentName == contentName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        time.hashCode ^
        type.hashCode ^
        subjectId.hashCode ^
        subjectName.hashCode ^
        moduleId.hashCode ^
        moduleName.hashCode ^
        contentId.hashCode ^
        contentName.hashCode;
  }
}
