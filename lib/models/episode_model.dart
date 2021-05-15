class EpisodeModel {
  EpisodeModel({
    this.title,
    this.baseUrl,
    this.id,
    this.linkStream,
    this.quality,
  });

  String title;
  String baseUrl;
  String id;
  String linkStream;
  EpisodeQualityModel quality;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
    title: json["title"],
    baseUrl: json["baseUrl"],
    id: json["id"],
    linkStream: json["link_stream"],
    quality: EpisodeQualityModel.fromJson(json["quality"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "baseUrl": baseUrl,
    "id": id,
    "link_stream": linkStream,
    "quality": quality.toJson(),
  };
}

class EpisodeQualityModel {
  EpisodeQualityModel({
    this.lowQuality,
    this.mediumQuality,
    this.highQuality,
  });

  HighQualityClass lowQuality;
  HighQualityClass mediumQuality;
  HighQualityClass highQuality;

  factory EpisodeQualityModel.fromJson(Map<String, dynamic> json) => EpisodeQualityModel(
    lowQuality: HighQualityClass.fromJson(json["low_quality"]),
    mediumQuality: HighQualityClass.fromJson(json["medium_quality"]),
    highQuality: HighQualityClass.fromJson(json["high_quality"]),
  );

  Map<String, dynamic> toJson() => {
    "low_quality": lowQuality.toJson(),
    "medium_quality": mediumQuality.toJson(),
    "high_quality": highQuality.toJson(),
  };
}

class HighQualityClass {
  HighQualityClass({
    this.quality,
    this.size,
    this.downloadLinks,
  });

  String quality;
  String size;
  List<DownloadLink> downloadLinks;

  factory HighQualityClass.fromJson(Map<String, dynamic> json) => HighQualityClass(
    quality: json["quality"],
    size: json["size"],
    downloadLinks: List<DownloadLink>.from(json["download_links"].map((x) => DownloadLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "quality": quality,
    "size": size,
    "download_links": List<dynamic>.from(downloadLinks.map((x) => x.toJson())),
  };
}

class DownloadLink {
  DownloadLink({
    this.host,
    this.link,
  });

  String host;
  String link;

  factory DownloadLink.fromJson(Map<String, dynamic> json) => DownloadLink(
    host: json["host"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "host": host,
    "link": link,
  };
}
