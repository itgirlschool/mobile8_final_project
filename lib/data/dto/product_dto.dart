class ProductDto {
  final String id;
  final String name;
  final String description;
  final String image;
  final int price;
  final int quantity;
  final String category;

  ProductDto({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.quantity,
    required this.category,
  });

  factory ProductDto.fromMap(Map<String, dynamic> map) {
    return ProductDto(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
      price: map['price'],
      quantity: map['quantity'],
      category: map['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'quantity': quantity,
      'category': category,
    };
  }
}