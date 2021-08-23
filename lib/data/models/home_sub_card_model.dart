import 'dart:convert';

class HomeSubCard {
  final String id;
  final String name;
  final int modules;
  final int contents;
  final int quiz;
  final int completdModules;
  final int completedContents;
  HomeSubCard({
    required this.id,
    required this.name,
    required this.modules,
    required this.contents,
    required this.quiz,
    required this.completdModules,
    required this.completedContents,
  });

  HomeSubCard copyWith({
    String? id,
    String? name,
    int? modules,
    int? contents,
    int? quiz,
    int? completdModules,
    int? completedContents,
  }) {
    return HomeSubCard(
      id: id ?? this.id,
      name: name ?? this.name,
      modules: modules ?? this.modules,
      contents: contents ?? this.contents,
      quiz: quiz ?? this.quiz,
      completdModules: completdModules ?? this.completdModules,
      completedContents: completedContents ?? this.completedContents,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'modules': modules,
      'contents': contents,
      'quiz': quiz,
      'completdModules': completdModules,
      'completedContents': completedContents,
    };
  }

  factory HomeSubCard.fromMap(Map<String, dynamic> map) {
    return HomeSubCard(
      id: map['id'],
      name: map['name'],
      modules: map['modules'],
      contents: map['contents'],
      quiz: map['quiz'],
      completdModules: map['completdModules'],
      completedContents: map['completedContents'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeSubCard.fromJson(String source) =>
      HomeSubCard.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HomeSubCard(id: $id, name: $name, modules: $modules, contents: $contents, quiz: $quiz, completdModules: $completdModules, completedContents: $completedContents)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeSubCard &&
        other.id == id &&
        other.name == name &&
        other.modules == modules &&
        other.contents == contents &&
        other.quiz == quiz &&
        other.completdModules == completdModules &&
        other.completedContents == completedContents;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        modules.hashCode ^
        contents.hashCode ^
        quiz.hashCode ^
        completdModules.hashCode ^
        completedContents.hashCode;
  }
}
