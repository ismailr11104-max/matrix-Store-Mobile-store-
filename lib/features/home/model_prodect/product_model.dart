import 'package:equatable/equatable.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:matrix_app/features/home/model_prodect/product_specs.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String nameEn;
  @HiveField(2)
  final String brand;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final String categoryId;
  @HiveField(5)
  final num price;
  @HiveField(6)
  final num originalPrice;
  @HiveField(7)
  final num discountPercentage;
  @HiveField(8)
  final num rating;
  @HiveField(9)
  final int reviewsCount;
  @HiveField(10)
  final String imageUrl;
  @HiveField(11)
  final int stock;
  @HiveField(12)
  final String descriptionEn;
  @HiveField(13)
  final ProductSpecs specs;
  @HiveField(14)
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
