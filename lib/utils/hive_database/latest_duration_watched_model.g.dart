// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_duration_watched_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LatestDurationWatchedModelAdapter
    extends TypeAdapter<LatestDurationWatchedModel> {
  @override
  final int typeId = 2;

  @override
  LatestDurationWatchedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LatestDurationWatchedModel(
      endpoint: fields[0] as String,
      duration: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LatestDurationWatchedModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.endpoint)
      ..writeByte(1)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LatestDurationWatchedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
