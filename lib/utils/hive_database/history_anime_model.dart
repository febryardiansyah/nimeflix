import 'package:hive/hive.dart';

part 'history_anime_model.g.dart';

@HiveType(typeId: 3)
class HistoryAnimeModel{
  @HiveField(0)
  final String endpoint;
  @HiveField(1)
  final String status;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String thumb;

  HistoryAnimeModel({this.endpoint, this.status, this.title, this.thumb});
}