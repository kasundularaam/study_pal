import 'dart:convert';

class FireUser {
  String uid;
  String name;
  String email;
  FireUser({
    required this.uid,
    required this.name,
    required this.email,
  });

  FireUser copyWith({
    String? uid,
    String? name,
    String? email,
  }) {
    return FireUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  factory FireUser.fromMap(Map<String, dynamic> map) {
    return FireUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FireUser.fromJson(String source) =>
      FireUser.fromMap(json.decode(source));

  @override
  String toString() => 'LmsUser(uid: $uid, name: $name, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FireUser &&
        other.uid == uid &&
        other.name == name &&
        other.email == email;
  }

  @override
  int get hashCode => uid.hashCode ^ name.hashCode ^ email.hashCode;
}
