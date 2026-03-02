import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food.dart';

class FoodService {
  static const String _baseUrl =
      'https://698297a89c3efeb892a2b63d.mockapi.io/api/Foods';

  /// Fetches the list of foods from the remote endpoint.
  Future<List<Food>> getFoods() async {
    final uri = Uri.parse(_baseUrl);
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Food.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load foods. Status: ${response.statusCode}');
    }
  }

  /// POSTs a new food to the endpoint and returns the created [Food].
  Future<Food> createFood({
    required String name,
    required String description,
    required double price,
    required String manufacturer,
    String? image,
  }) async {
    final uri = Uri.parse(_baseUrl);
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'description': description,
        'price': price,
        'manufacturer': manufacturer,
        'image': image,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Food.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create food. Status: ${response.statusCode}');
    }
  }
}
