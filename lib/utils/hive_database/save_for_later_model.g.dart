// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_for_later_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaveForLaterModelAdapter extends TypeAdapter<SaveForLaterModel> {
  @override
  final int typeId = 0;

  @override
  SaveForLaterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaveForLaterModel(
      endpoint: fields[0] as String,
      status: fields[1] as String,
      title: fields[2] as String,
      thumb: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SaveForLaterModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.endpoint)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.thumb);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveForLaterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
