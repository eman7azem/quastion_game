class Category {
  final int id;
  final String name;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class CategoriesResponse {
  final bool success;
  final List<Category> data;
  final String message;

  CategoriesResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Category> dataList = list.map((i) => Category.fromJson(i)).toList();

    return CategoriesResponse(
      success: json['success'],
      data: dataList,
      message: json['message'],
    );
  }
}
