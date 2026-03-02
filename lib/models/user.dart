class User {
  final int id;
  final String username;
  final String avatar;
  final String password;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.avatar,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'avatar': avatar,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: int.tryParse(map['id'].toString()) ?? 0,
      username: map['username'],
      password: map['password'],
      avatar: map['avatar'],
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User.fromMap(json);
  }
}
