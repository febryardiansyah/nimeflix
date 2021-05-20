import 'package:hive/hive.dart';

part 'latest_episode_model.g.dart';

@HiveType(typeId: 1)
class LatestEpisodeModel{
  @HiveField(0)
  final String animeEndpoint;
  @HiveField(1)
  final String episodeEndpoint;
  @HiveField(2)
  final String episodeTitle;
  @HiveField(3)
  final int lastEpisode;

  LatestEpisodeModel({this.animeEndpoint, this.episodeEndpoint,this.episodeTitle,this.lastEpisode});
}