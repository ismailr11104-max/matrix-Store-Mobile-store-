import 'package:equatable/equatable.dart';

class ProductSpecs extends Equatable {
  final String screen;
  final String processor;
  final String storage;
  final String camera;
  final String os;

  ProductSpecs({
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
  // TODO: implement props
  List<Object?> get props => [screen, processor, storage, camera, os];
}
