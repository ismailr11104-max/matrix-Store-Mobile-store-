class CategoryModel {
  final String id;
  final String title;
  final String imageUrl;

  CategoryModel({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      title: json['name_en'] ?? json['name'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'imageUrl': imageUrl};
  }
}
