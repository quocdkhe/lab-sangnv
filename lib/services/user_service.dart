import '../models/user.dart';
import '../db/database_helper.dart';

class UserService {
  final DatabaseHelper _db = DatabaseHelper.instance;

  /// Authenticates user by checking credentials against the database.
  Future<User?> login(String username, String password) async {
    try {
      final db = await _db.database;
      final result = await db.query(
        'users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password],
      );
      if (result.isNotEmpty) {
        return User.fromMap(result.first);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  /// Fetches all users from the database.
  Future<List<User>> getUsers() async {
    try {
      final db = await _db.database;
      final result = await db.query('users');
      return result.map((map) => User.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  /// Get a single user by ID from the database.
  Future<User?> getUserById(String id) async {
    try {
      final db = await _db.database;
      final result = await db.query('users', where: 'id = ?', whereArgs: [id]);
      if (result.isNotEmpty) {
        return User.fromMap(result.first);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }
}
