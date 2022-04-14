import 'package:hive/hive.dart';
import 'package:nimeflix/utils/hive_database/latest_episode_model.dart';

import '../constants/BaseConstants.dart';

class DbRepo {
  Future<void> getLatestEps() async{
    final _latestEpisodeBox = Hive.box(BaseConstants.hLatestEpisode);
    _latestEpisodeBox.values.toList();
  }
}