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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse(json['id']),
      username: json['username'],
      password: json['password'],
      avatar: json['avatar'],
    );
  }
}
