// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistent_data.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersistentDataModelAdapter extends TypeAdapter<PersistentDataModel> {
  @override
  final int typeId = 0;

  @override
  PersistentDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersistentDataModel(
      recentlySearchedCities: (fields[0] as List?)?.cast<String>(),
      isCelsius: fields[1] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PersistentDataModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.recentlySearchedCities)
      ..writeByte(1)
      ..write(obj.isCelsius);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersistentDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
