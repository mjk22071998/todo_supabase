import 'dart:convert';

class Users {
  String name;
  String email;
  Users({
    required this.name,
    required this.email,
  });

  Users copyWith({
    String? name,
    String? email,
  }) {
    return Users(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'email': email});
  
    return result;
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));

  @override
  String toString() => 'Users(name: $name, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Users &&
      other.name == name &&
      other.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode;
}
