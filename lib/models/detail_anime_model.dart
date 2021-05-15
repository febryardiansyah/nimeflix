class DetailAnimeModel {
  DetailAnimeModel({
    this.thumb,
    this.animeId,
    this.synopsis,
    this.title,
    this.japanase,
    this.score,
    this.producer,
    this.type,
    this.status,
    this.totalEpisode,
    this.duration,
    this.releaseDate,
    this.studio,
    this.genreList,
    this.episodeList,
    this.batchLink,
  });

  String thumb;
  String animeId;
  String synopsis;
  String title;
  String japanase;
  double score;
  String producer;
  String type;
  String status;
  dynamic totalEpisode;
  String duration;
  String releaseDate;
  String studio;
  List<GenreListModel> genreList;
  List<EpisodeListModel> episodeList;
  BatchLinkModel batchLink;

  factory DetailAnimeModel.fromJson(Map<String, dynamic> json) => DetailAnimeModel(
    thumb: json["thumb"],
    animeId: json["anime_id"],
    synopsis: json["synopsis"],
    title: json["title"],
    japanase: json["japanase"],
    score: json["score"],
    producer: json["producer"],
    type: json["type"],
    status: json["status"],
    totalEpisode: json["total_episode"],
    duration: json["duration"],
    releaseDate: json["release_date"],
    studio: json["studio"],
    genreList: List<GenreListModel>.from(json["genre_list"].map((x) => GenreListModel.fromJson(x))),
    episodeList: List<EpisodeListModel>.from(json["episode_list"].map((x) => EpisodeListModel.fromJson(x))),
    batchLink: BatchLinkModel.fromJson(json["batch_link"]),
  );

  Map<String, dynamic> toJson() => {
    "thumb": thumb,
    "anime_id": animeId,
    "synopsis": synopsis,
    "title": title,
    "japanase": japanase,
    "score": score,
    "producer": producer,
    "type": type,
    "status": status,
    "total_episode": totalEpisode,
    "duration": duration,
    "release_date": releaseDate,
    "studio": studio,
    "genre_list": List<dynamic>.from(genreList.map((x) => x.toJson())),
    "episode_list": List<dynamic>.from(episodeList.map((x) => x.toJson())),
    "batch_link": batchLink.toJson(),
  };
}

class BatchLinkModel {
  BatchLinkModel({
    this.id,
    this.link,
  });

  String id;
  String link;

  factory BatchLinkModel.fromJson(Map<String, dynamic> json) => BatchLinkModel(
    id: json["id"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "link": link,
  };
}

class EpisodeListModel {
  EpisodeListModel({
    this.title,
    this.id,
    this.link,
    this.uploadedOn,
  });

  String title;
  String id;
  String link;
  String uploadedOn;

  factory EpisodeListModel.fromJson(Map<String, dynamic> json) => EpisodeListModel(
    title: json["title"],
    id: json["id"],
    link: json["link"],
    uploadedOn: json["uploaded_on"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
    "link": link,
    "uploaded_on": uploadedOn,
  };
}

class GenreListModel {
  GenreListModel({
    this.genreName,
    this.genreId,
    this.genreLink,
  });

  String genreName;
  String genreId;
  String genreLink;

  factory GenreListModel.fromJson(Map<String, dynamic> json) => GenreListModel(
    genreName: json["genre_name"],
    genreId: json["genre_id"],
    genreLink: json["genre_link"],
  );

  Map<String, dynamic> toJson() => {
    "genre_name": genreName,
    "genre_id": genreId,
    "genre_link": genreLink,
  };
}
