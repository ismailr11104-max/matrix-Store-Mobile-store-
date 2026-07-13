import 'package:equatable/equatable.dart';
import 'package:hive_ce_flutter/adapters.dart';

part 'product_specs.g.dart';

@HiveType(typeId: 4)
class ProductSpecs extends Equatable {
  @HiveField(0)
  final String screen;
  @HiveField(1)
  final String processor;
  @HiveField(2)
  final String storage;
  @HiveField(3)
  final String camera;
  @HiveField(4)
  final String os;

  const ProductSpecs({
    required this.screen,
    required this.processor,
    required this.storage,
    required this.camera,
    required this.os,
  });

  factory ProductSpecs.fromJson(Map<String, dynamic> json) {
    return ProductSpecs(
      screen: json['screen'] ?? '',
      processor: json['processor'] ?? '',
      storage: json['storage'] ?? '',
      camera: json['camera'] ?? '',
      os: json['os'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'screen': screen,
      'processor': processor,
      'storage': storage,
      'camera': camera,
      'os': os,
    };
  }

  @override
  List<Object?> get props => [screen, processor, storage, camera, os];
}
