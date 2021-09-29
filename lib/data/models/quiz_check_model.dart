import 'dart:convert';

class QuizCheck {
  final String id;
  final String question;
  final String correctAnswer;
  String checkedAnswer;
  final int index;
  QuizCheck({
    required this.id,
    required this.question,
    required this.correctAnswer,
    required this.checkedAnswer,
    required this.index,
  });

  QuizCheck copyWith({
    String? id,
    String? question,
    String? correctAnswer,
    String? checkedAnswer,
    int? index,
  }) {
    return QuizCheck(
      id: id ?? this.id,
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      checkedAnswer: checkedAnswer ?? this.checkedAnswer,
      index: index ?? this.index,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'correctAnswer': correctAnswer,
      'checkedAnswer': checkedAnswer,
      'index': index,
    };
  }

  factory QuizCheck.fromMap(Map<String, dynamic> map) {
    return QuizCheck(
      id: map['id'],
      question: map['question'],
      correctAnswer: map['correctAnswer'],
      checkedAnswer: map['checkedAnswer'],
      index: map['index'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizCheck.fromJson(String source) =>
      QuizCheck.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QuizCheck(id: $id, question: $question, correctAnswer: $correctAnswer, checkedAnswer: $checkedAnswer, index: $index)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuizCheck &&
        other.id == id &&
        other.question == question &&
        other.correctAnswer == correctAnswer &&
        other.checkedAnswer == checkedAnswer &&
        other.index == index;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        question.hashCode ^
        correctAnswer.hashCode ^
        checkedAnswer.hashCode ^
        index.hashCode;
  }
}
