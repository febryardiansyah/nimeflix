import 'package:hive/hive.dart';

part 'latest_duration_watched_model.g.dart';

@HiveType(typeId: 2)
class LatestDurationWatchedModel {
  @HiveField(0)
  final String endpoint;
  @HiveField(1)
  final String duration;

  LatestDurationWatchedModel({this.endpoint, this.duration});
}