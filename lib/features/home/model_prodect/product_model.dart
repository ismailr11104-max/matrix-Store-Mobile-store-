import 'package:equatable/equatable.dart';
import 'package:matrix_app/features/home/model_prodect/product_specs.dart';

class ProductModel extends Equatable {
  final int id;
  final String nameEn;
  final String brand;
  final String category;
  final String categoryId;
  final num price;
  final num originalPrice;
  final num discountPercentage;
  final num rating;
  final int reviewsCount;
  final String imageUrl;
  final int stock;
  final String descriptionEn;
  final ProductSpecs specs;
  final int releaseYear;

  const ProductModel({
    required this.id,
    required this.nameEn,
    required this.brand,
    required this.category,
    required this.categoryId,
    required this.price,
    required this.originalPrice,
    required this.discountPercentage,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    required this.stock,
    required this.descriptionEn,
    required this.specs,
    required this.releaseYear,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      nameEn: json['name_en'] ?? '',
      brand: json['brand'] ?? '',
      category: json['category'] ?? json['product'] ?? '',
      categoryId: json['category_id'] ?? '',
      price: json['price'] ?? 0,
      originalPrice: json['original_price'] ?? 0,
      discountPercentage: json['discount_percentage'] ?? 0,
      rating: json['rating'] ?? 0.0,
      reviewsCount: json['reviews_count'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      stock: json['stock'] ?? 0,
      descriptionEn: json['description_en'] ?? '',
      specs: ProductSpecs.fromJson(json['specs'] ?? {}),
      releaseYear: json['release_year'] ?? 2026,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'brand': brand,
      'product': category,
      'category_id': categoryId,
      'price': price,
      'original_price': originalPrice,
      'discount_percentage': discountPercentage,
      'rating': rating,
      'reviews_count': reviewsCount,
      'image_url': imageUrl,
      'stock': stock,
      'description_en': descriptionEn,
      'specs': specs.toJson(),
      'release_year': releaseYear,
    };
  }

  @override
  List<Object?> get props => [
    id,
    nameEn,
    brand,
    category,
    categoryId,
    price,
    originalPrice,
    discountPercentage,
    rating,
    reviewsCount,
    imageUrl,
    stock,
    descriptionEn,
    specs,
    releaseYear,
  ];
}
