import 'dart:convert';

import 'package:flutter/material.dart';

class AddConEvCalCuMod {
  final DateTime date;
  final TimeOfDay time;
  final String subjectId;
  final String subjectName;
  final String moduleId;
  final String moduleName;
  final String contentId;
  final String contentName;
  AddConEvCalCuMod({
    required this.date,
    required this.time,
    required this.subjectId,
    required this.subjectName,
    required this.moduleId,
    required this.moduleName,
    required this.contentId,
    required this.contentName,
  });

  AddConEvCalCuMod copyWith({
    DateTime? date,
    TimeOfDay? time,
    String? subjectId,
    String? subjectName,
    String? moduleId,
    String? moduleName,
    String? contentId,
    String? contentName,
  }) {
    return AddConEvCalCuMod(
      date: date ?? this.date,
      time: time ?? this.time,
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
      'date': date.millisecondsSinceEpoch,
      'time': time,
      'subjectId': subjectId,
      'subjectName': subjectName,
      'moduleId': moduleId,
      'moduleName': moduleName,
      'contentId': contentId,
      'contentName': contentName,
    };
  }

  factory AddConEvCalCuMod.fromMap(Map<String, dynamic> map) {
    return AddConEvCalCuMod(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      time: map['time'],
      subjectId: map['subjectId'],
      subjectName: map['subjectName'],
      moduleId: map['moduleId'],
      moduleName: map['moduleName'],
      contentId: map['contentId'],
      contentName: map['contentName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddConEvCalCuMod.fromJson(String source) =>
      AddConEvCalCuMod.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddEvCalCuMod(date: $date, time: $time, subjectId: $subjectId, subjectName: $subjectName, moduleId: $moduleId, moduleName: $moduleName, contentId: $contentId, contentName: $contentName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddConEvCalCuMod &&
        other.date == date &&
        other.time == time &&
        other.subjectId == subjectId &&
        other.subjectName == subjectName &&
        other.moduleId == moduleId &&
        other.moduleName == moduleName &&
        other.contentId == contentId &&
        other.contentName == contentName;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        time.hashCode ^
        subjectId.hashCode ^
        subjectName.hashCode ^
        moduleId.hashCode ^
        moduleName.hashCode ^
        contentId.hashCode ^
        contentName.hashCode;
  }
}
