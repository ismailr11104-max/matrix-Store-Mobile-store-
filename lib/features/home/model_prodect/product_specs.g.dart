// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_specs.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductSpecsAdapter extends TypeAdapter<ProductSpecs> {
  @override
  final typeId = 5;

  @override
  ProductSpecs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductSpecs(
      screen: fields[0] as String,
      processor: fields[1] as String,
      storage: fields[2] as String,
      camera: fields[3] as String,
      os: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductSpecs obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.screen)
      ..writeByte(1)
      ..write(obj.processor)
      ..writeByte(2)
      ..write(obj.storage)
      ..writeByte(3)
      ..write(obj.camera)
      ..writeByte(4)
      ..write(obj.os);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductSpecsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
