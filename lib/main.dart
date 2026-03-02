import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_crud/db/database_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'pages/login_page.dart';
import 'pages/food_list_page.dart';
import 'pages/add_food_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  // Initialize DB before app starts
  await DatabaseHelper.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food CRUD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/foods': (context) => const FoodListPage(),
        '/food/add': (context) => const AddFoodPage(),
      },
    );
  }
}
