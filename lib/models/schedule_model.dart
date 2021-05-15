class ScheduleModel {
  ScheduleModel({
    this.day,
    this.animeList,
  });

  String day;
  List<AnimeList> animeList;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
    day: json["day"],
    animeList: List<AnimeList>.from(json["animeList"].map((x) => AnimeList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "animeList": List<dynamic>.from(animeList.map((x) => x.toJson())),
  };
}

class AnimeList {
  AnimeList({
    this.animeName,
    this.id,
    this.link,
  });

  String animeName;
  String id;
  String link;

  factory AnimeList.fromJson(Map<String, dynamic> json) => AnimeList(
    animeName: json["anime_name"],
    id: json["id"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "anime_name": animeName,
    "id": id,
    "link": link,
  };
}
