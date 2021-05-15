class SearchResultModel {
  SearchResultModel({
    this.thumb,
    this.title,
    this.link,
    this.id,
    this.status,
    this.score,
    this.genreList,
  });

  String thumb;
  String title;
  String link;
  String id;
  String status;
  double score;
  List<GenreList> genreList;

  factory SearchResultModel.fromJson(Map<String, dynamic> json) => SearchResultModel(
    thumb: json["thumb"],
    title: json["title"],
    link: json["link"],
    id: json["id"],
    status: json["status"],
    score: json["score"],
    genreList: List<GenreList>.from(json["genre_list"].map((x) => GenreList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "thumb": thumb,
    "title": title,
    "link": link,
    "id": id,
    "status": status,
    "score": score,
    "genre_list": List<dynamic>.from(genreList.map((x) => x.toJson())),
  };
}

class GenreList {
  GenreList({
    this.genreTitle,
    this.genreLink,
    this.genreId,
  });

  String genreTitle;
  String genreLink;
  String genreId;

  factory GenreList.fromJson(Map<String, dynamic> json) => GenreList(
    genreTitle: json["genre_title"],
    genreLink: json["genre_link"],
    genreId: json["genre_id"],
  );

  Map<String, dynamic> toJson() => {
    "genre_title": genreTitle,
    "genre_link": genreLink,
    "genre_id": genreId,
  };
}
