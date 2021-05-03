class OngoingAnimeModel {
  OngoingAnimeModel({
    this.title,
    this.id,
    this.thumb,
    this.episode,
    this.uploadedOn,
    this.dayUpdated,
    this.link,
  });

  String title;
  String id;
  String thumb;
  String episode;
  String uploadedOn;
  String dayUpdated;
  String link;

  factory OngoingAnimeModel.fromJson(Map<String, dynamic> json) => OngoingAnimeModel(
    title: json["title"],
    id: json["id"],
    thumb: json["thumb"],
    episode: json["episode"],
    uploadedOn: json["uploaded_on"],
    dayUpdated: json["day_updated"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
    "thumb": thumb,
    "episode": episode,
    "uploaded_on": uploadedOn,
    "day_updated": dayUpdated,
    "link": link,
  };
}
