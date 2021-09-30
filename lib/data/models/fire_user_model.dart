import 'dart:convert';

class FireUser {
  String uid;
  String name;
  String email;
  String profilePic;
  FireUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePic,
  });

  FireUser copyWith({
    String? uid,
    String? name,
    String? email,
    String? profilePic,
  }) {
    return FireUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePic': profilePic,
    };
  }

  factory FireUser.fromMap(Map<String, dynamic> map) {
    return FireUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      profilePic: map['profilePic'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FireUser.fromJson(String source) =>
      FireUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FireUser(uid: $uid, name: $name, email: $email, profilePic: $profilePic)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FireUser &&
        other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.profilePic == profilePic;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ name.hashCode ^ email.hashCode ^ profilePic.hashCode;
  }
}
