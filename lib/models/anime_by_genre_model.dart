class AnimeByGenreModel {
  AnimeByGenreModel({
    this.animeName,
    this.link,
    this.id,
    this.studio,
    this.episode,
    this.score,
    this.releaseDate,
    this.genreList,
  });

  String animeName;
  String link;
  String id;
  String studio;
  String episode;
  num score;
  String releaseDate;
  List<GenreList> genreList;

  factory AnimeByGenreModel.fromJson(Map<String, dynamic> json) => AnimeByGenreModel(
    animeName: json["anime_name"],
    link: json["link"],
    id: json["id"],
    studio: json["studio"],
    episode: json["episode"],
    score: json["score"],
    releaseDate: json["release_date"],
    genreList: List<GenreList>.from(json["genre_list"].map((x) => GenreList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "anime_name": animeName,
    "link": link,
    "id": id,
    "studio": studio,
    "episode": episode,
    "score": score,
    "release_date": releaseDate,
    "genre_list": List<dynamic>.from(genreList.map((x) => x.toJson())),
  };
}

class GenreList {
  GenreList({
    this.genreName,
    this.genreLink,
    this.genreId,
  });

  String genreName;
  String genreLink;
  String genreId;

  factory GenreList.fromJson(Map<String, dynamic> json) => GenreList(
    genreName: json["genre_name"],
    genreLink: json["genre_link"],
    genreId: json["genre_id"],
  );

  Map<String, dynamic> toJson() => {
    "genre_name": genreName,
    "genre_link": genreLink,
    "genre_id": genreId,
  };
}
