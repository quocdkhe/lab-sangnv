import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    print('Database path: $dbPath');
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1, // fresh start
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // ---------- Create tables ----------
    await db.execute('''
      CREATE TABLE foods (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        price REAL NOT NULL,
        manufacturer TEXT,
        image TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        avatar TEXT
      )
    ''');

    // ---------- Seed data ----------
    await _seedUsers(db);
    await _seedFoods(db);
  }

  // ---------- Seed Users ----------
  Future<void> _seedUsers(Database db) async {
    final users = [
      {'username': 'admin', 'password': '123456', 'avatar': 'admin.png'},
      {'username': 'john', 'password': 'password', 'avatar': 'john.png'},
      {'username': 'mary', 'password': 'password', 'avatar': 'mary.png'},
    ];

    for (final user in users) {
      await db.insert('users', user);
    }
  }

  // ---------- Seed Foods ----------
  Future<void> _seedFoods(Database db) async {
    final foods = [
      {
        "name": "Cheese Burger",
        "description":
            "Juicy beef burger with melted cheese and fresh vegetables.",
        "price": 4.5,
        "manufacturer": "Food Factory A",
        "image": "https://images.unsplash.com/photo-1550547660-d9450f859349",
      },
      {
        "name": "Pepperoni Pizza",
        "description": "Hot pizza topped with pepperoni and mozzarella cheese.",
        "price": 8.99,
        "manufacturer": "Italian Kitchen",
        "image": "https://images.unsplash.com/photo-1604382355076-af4b0eb60143",
      },
      {
        "name": "Fried Chicken",
        "description": "Crispy fried chicken with secret spices.",
        "price": 6.2,
        "manufacturer": "Chicken House",
        "image": "https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec",
      },
      {
        "name": "Sushi Set",
        "description": "Fresh sushi with salmon, tuna and rice.",
        "price": 12.5,
        "manufacturer": "Tokyo Foods",
        "image": "https://images.unsplash.com/photo-1579584425555-c3ce17fd4351",
      },
      {
        "name": "Mỳ tôm",
        "description": "Mỳ tôm",
        "price": 2,
        "manufacturer": "VN",
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8WrcZnmpYI5RDsMLcZ5w_j44xJ5fSDBaQHQ&s",
      },
      {
        "name": "Phở",
        "description": "Phở",
        "price": 2.5,
        "manufacturer": "VN",
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbGpgL8CYhZ8eTsBAHQNFoH4cAEN5ejCPwAA&s",
      },
      {
        "name": "Bún chả",
        "description": "Bún chả Hà Nội hương vị xưa",
        "price": 2,
        "manufacturer": "Hà Nội, VN",
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4FLvnGIXP9QJZTJ02Mo8DCTw8g5XDcenjlA&s",
      },
    ];

    for (final food in foods) {
      await db.insert('foods', food);
    }
  }
}
