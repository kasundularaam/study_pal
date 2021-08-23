import 'dart:convert';

class PieSubPres {
  final String name;
  final int workedTime;
  PieSubPres({
    required this.name,
    required this.workedTime,
  });

  PieSubPres copyWith({
    String? name,
    int? workedTime,
  }) {
    return PieSubPres(
      name: name ?? this.name,
      workedTime: workedTime ?? this.workedTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'workedTime': workedTime,
    };
  }

  factory PieSubPres.fromMap(Map<String, dynamic> map) {
    return PieSubPres(
      name: map['name'],
      workedTime: map['workedTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PieSubPres.fromJson(String source) =>
      PieSubPres.fromMap(json.decode(source));

  @override
  String toString() => 'PieSubPres(name: $name, workedTime: $workedTime)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PieSubPres &&
        other.name == name &&
        other.workedTime == workedTime;
  }

  @override
  int get hashCode => name.hashCode ^ workedTime.hashCode;
}
