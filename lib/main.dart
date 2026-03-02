import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/food_list_page.dart';
import 'pages/add_food_page.dart';

void main() {
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
