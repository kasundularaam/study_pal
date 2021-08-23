import 'dart:convert';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
  Question({
    required this.id,
    required this.question,
    required this.correctAnswer,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.module,
  });

  String id;
  String question;
  String correctAnswer;
  String answer1;
  String answer2;
  String answer3;
  String module;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        question: json["question"],
        correctAnswer: json["correctAnswer"],
        answer1: json["answer1"],
        answer2: json["answer2"],
        answer3: json["answer3"],
        module: json["module"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "correctAnswer": correctAnswer,
        "answer1": answer1,
        "answer2": answer2,
        "answer3": answer3,
        "module": module,
      };
}
