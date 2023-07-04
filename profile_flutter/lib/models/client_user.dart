class ClientUser {
  final String uid;
  final String username;
  final String email;
  ClientUser({
    required this.uid,
    required this.username,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
    };
  }

  factory ClientUser.fromMap(Map<String, dynamic> map) {
    return ClientUser(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
    );
  }

//   String toJson() => json.encode(toMap());
//   factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
