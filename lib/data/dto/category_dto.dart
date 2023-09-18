class CategoryDto {
  final String id;
  final String name;
  final String image;

  CategoryDto({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryDto.fromMap(Map<String, dynamic> map) {
    return CategoryDto(
      id: map['id'],
      name: map['name'],
      image: map['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}