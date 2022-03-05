class MirrorStreamModel {
  MirrorStreamModel({
    this.title,
    this.baseUrl,
    this.id,
    this.streamLink,
    this.linkStream,
  });

  String title;
  String baseUrl;
  String id;
  String streamLink;
  String linkStream;

  factory MirrorStreamModel.fromJson(Map<String, dynamic> json) => MirrorStreamModel(
    title: json["title"],
    baseUrl: json["baseUrl"],
    id: json["id"],
    streamLink: json["streamLink"],
    linkStream: json["link_stream"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "baseUrl": baseUrl,
    "id": id,
    "streamLink": streamLink,
    "link_stream": linkStream,
  };
}
