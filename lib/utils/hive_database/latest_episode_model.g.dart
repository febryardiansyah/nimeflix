// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_episode_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LatestEpisodeModelAdapter extends TypeAdapter<LatestEpisodeModel> {
  @override
  final int typeId = 1;

  @override
  LatestEpisodeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LatestEpisodeModel(
      animeEndpoint: fields[0] as String,
      episodeEndpoint: fields[1] as String,
      episodeTitle: fields[2] as String,
      lastEpisode: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LatestEpisodeModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.animeEndpoint)
      ..writeByte(1)
      ..write(obj.episodeEndpoint)
      ..writeByte(2)
      ..write(obj.episodeTitle)
      ..writeByte(3)
      ..write(obj.lastEpisode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LatestEpisodeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
