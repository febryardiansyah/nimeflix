class BatchAnimeModel {
  BatchAnimeModel({
    this.title,
    this.status,
    this.baseUrl,
    this.downloadList,
  });

  String title;
  String status;
  String baseUrl;
  DownloadList downloadList;

  factory BatchAnimeModel.fromJson(Map<String, dynamic> json) => BatchAnimeModel(
    title: json["title"],
    status: json["status"],
    baseUrl: json["baseUrl"],
    downloadList: DownloadList.fromJson(json["download_list"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "status": status,
    "baseUrl": baseUrl,
    "download_list": downloadList.toJson(),
  };
}

class DownloadList {
  DownloadList({
    this.lowQuality,
    this.mediumQuality,
    this.highQuality,
  });

  Quality lowQuality;
  Quality mediumQuality;
  Quality highQuality;

  factory DownloadList.fromJson(Map<String, dynamic> json) => DownloadList(
    lowQuality: Quality.fromJson(json["low_quality"]),
    mediumQuality: Quality.fromJson(json["medium_quality"]),
    highQuality: Quality.fromJson(json["high_quality"]),
  );

  Map<String, dynamic> toJson() => {
    "low_quality": lowQuality.toJson(),
    "medium_quality": mediumQuality.toJson(),
    "high_quality": highQuality.toJson(),
  };
}

class Quality {
  Quality({
    this.quality,
    this.size,
    this.downloadLinks,
  });

  String quality;
  String size;
  List<DownloadLink> downloadLinks;

  factory Quality.fromJson(Map<String, dynamic> json) => Quality(
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
