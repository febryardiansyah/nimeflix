class MessagingModel {
  MessagingModel({
    this.logs,
    this.id,
    this.title,
    this.version,
    this.link,
    this.v,
  });

  List<String> logs;
  String id;
  String title;
  String version;
  String link;
  int v;

  factory MessagingModel.fromJson(Map<String, dynamic> json) => MessagingModel(
    logs: List<String>.from(json["logs"].map((x) => x)),
    id: json["_id"],
    title: json["title"],
    version: json["version"],
    link: json["link"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "logs": List<dynamic>.from(logs.map((x) => x)),
    "_id": id,
    "title": title,
    "version": version,
    "link": link,
    "__v": v,
  };
}
