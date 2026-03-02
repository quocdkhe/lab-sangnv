import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  static const String _baseUrl =
      'https://698297a89c3efeb892a2b63d.mockapi.io/api/users';

  Future<User?> login(String username, String password) async {
    final uri = Uri.parse(_baseUrl);
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch users. Status: ${response.statusCode}');
    }

    final List<dynamic> jsonList = jsonDecode(response.body);
    final users = jsonList.map((json) => User.fromJson(json)).toList();

    try {
      return users.firstWhere(
        (u) => u.username == username && u.password == password,
      );
    } catch (_) {
      return null;
    }
  }

  Future<List<User>> getUsers() async {
    final uri = Uri.parse(_baseUrl);
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch users. Status: ${response.statusCode}');
    }

    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => User.fromJson(json)).toList();
  }
}
