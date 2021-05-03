class CompleteAnimeModel {
  CompleteAnimeModel({
    this.title,
    this.id,
    this.thumb,
    this.episode,
    this.uploadedOn,
    this.score,
    this.link,
  });

  String title;
  String id;
  String thumb;
  String episode;
  String uploadedOn;
  double score;
  String link;

  factory CompleteAnimeModel.fromJson(Map<String, dynamic> json) => CompleteAnimeModel(
    title: json["title"],
    id: json["id"],
    thumb: json["thumb"],
    episode: json["episode"],
    uploadedOn: json["uploaded_on"],
    score: json["score"].toDouble(),
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
    "thumb": thumb,
    "episode": episode,
    "uploaded_on": uploadedOn,
    "score": score,
    "link": link,
  };
}
