class EpisodeModel {
  EpisodeModel({
    this.title,
    this.baseUrl,
    this.id,
    this.linkStream,
    this.quality,
    this.mirror1,
    this.mirror2,
    this.mirror3,
    this.alternateStream,
    this.next,
    this.prev,
  });

  String title;
  String baseUrl;
  String id;
  String linkStream;
  String alternateStream;
  String next;
  String prev;
  EpisodeQualityModel quality;
  MirrorQuality mirror1;
  MirrorQuality mirror2;
  MirrorQuality mirror3;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
    title: json["title"],
    baseUrl: json["baseUrl"],
    id: json["id"],
    linkStream: json["link_stream"],
    alternateStream: json['alternate_stream'],
    next: json['next'],
    prev: json['prev'],
    quality: EpisodeQualityModel.fromJson(json["quality"]),
    mirror1: MirrorQuality.fromJson(json['mirror1']),
    mirror2: MirrorQuality.fromJson(json['mirror2']),
    mirror3: MirrorQuality.fromJson(json['mirror3'])
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "baseUrl": baseUrl,
    "id": id,
    "link_stream": linkStream,
    "quality": quality.toJson(),
  };
}

class MirrorQuality{
  String quality;
  List<MirrorList> mirrorList;

  MirrorQuality({this.quality, this.mirrorList});

  factory MirrorQuality.fromJson(Map<String,dynamic>json){
    return MirrorQuality(
      quality: json['quality'],
      mirrorList: List<MirrorList>.from(json['mirrorList'].map((json)=>MirrorList.fromJson(json)))
    );
  }
}

class MirrorList{
  String id;
  String host;

  MirrorList({this.id, this.host});

  factory MirrorList.fromJson(Map<String,dynamic>json){
    return MirrorList(
      id: json['id'],
      host: json['host']
    );
  }
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
