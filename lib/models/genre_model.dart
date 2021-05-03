class GenreModel {
  GenreModel({
    this.genreName,
    this.id,
    this.link,
    this.imageLink,
  });

  String genreName;
  String id;
  String link;
  String imageLink;

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
    genreName: json["genre_name"],
    id: json["id"],
    link: json["link"],
    imageLink: json["image_link"],
  );

  Map<String, dynamic> toJson() => {
    "genre_name": genreName,
    "id": id,
    "link": link,
    "image_link": imageLink,
  };
}
