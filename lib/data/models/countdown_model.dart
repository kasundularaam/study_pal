import 'dart:convert';

class Countdown {
  final String countdownId;
  final String examTitle;
  final int examTimeStamp;
  Countdown({
    required this.countdownId,
    required this.examTitle,
    required this.examTimeStamp,
  });

  Countdown copyWith({
    String? countdownId,
    String? examTitle,
    int? examTimeStamp,
  }) {
    return Countdown(
      countdownId: countdownId ?? this.countdownId,
      examTitle: examTitle ?? this.examTitle,
      examTimeStamp: examTimeStamp ?? this.examTimeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'countdownId': countdownId,
      'examTitle': examTitle,
      'examTimeStamp': examTimeStamp,
    };
  }

  factory Countdown.fromMap(Map<String, dynamic> map) {
    return Countdown(
      countdownId: map['countdownId'],
      examTitle: map['examTitle'],
      examTimeStamp: map['examTimeStamp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Countdown.fromJson(String source) =>
      Countdown.fromMap(json.decode(source));

  @override
  String toString() =>
      'CountdownModel(countdownId: $countdownId, examTitle: $examTitle, examTimeStamp: $examTimeStamp)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Countdown &&
        other.countdownId == countdownId &&
        other.examTitle == examTitle &&
        other.examTimeStamp == examTimeStamp;
  }

  @override
  int get hashCode =>
      countdownId.hashCode ^ examTitle.hashCode ^ examTimeStamp.hashCode;
}
