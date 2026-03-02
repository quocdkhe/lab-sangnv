import 'package:flutter/scheduler.dart';

class Food {
  final int id;
  final String name;
  final String description;
  final double price;
  final String manufacturer;
  final String? image;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.manufacturer,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'manufacturer': manufacturer,
      'image': image,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      id: int.tryParse(map['id'].toString()) ?? 0,
      name: map['name'],
      description: map['description'],
      price: (map['price'] as num).toDouble(),
      manufacturer: map['manufacturer'],
      image: map['image'],
    );
  }

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food.fromMap(json);
  }
}
