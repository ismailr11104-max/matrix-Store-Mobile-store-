// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final typeId = 1;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: (fields[0] as num).toInt(),
      nameEn: fields[1] as String,
      brand: fields[2] as String,
      category: fields[3] as String,
      categoryId: fields[4] as String,
      price: fields[5] as num,
      originalPrice: fields[6] as num,
      discountPercentage: fields[7] as num,
      rating: fields[8] as num,
      reviewsCount: (fields[9] as num).toInt(),
      imageUrl: fields[10] as String,
      stock: (fields[11] as num).toInt(),
      descriptionEn: fields[12] as String,
      specs: fields[13] as ProductSpecs,
      releaseYear: (fields[14] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nameEn)
      ..writeByte(2)
      ..write(obj.brand)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.categoryId)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.originalPrice)
      ..writeByte(7)
      ..write(obj.discountPercentage)
      ..writeByte(8)
      ..write(obj.rating)
      ..writeByte(9)
      ..write(obj.reviewsCount)
      ..writeByte(10)
      ..write(obj.imageUrl)
      ..writeByte(11)
      ..write(obj.stock)
      ..writeByte(12)
      ..write(obj.descriptionEn)
      ..writeByte(13)
      ..write(obj.specs)
      ..writeByte(14)
      ..write(obj.releaseYear);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
