class Food {
  final String id;
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

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'].toString(),
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      manufacturer: json['manufacturer'] as String,
      image: json['image'] as String?,
    );
  }
}
