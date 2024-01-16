


class CarpetasModel {
  String? carpDescripcion;
  String? carpId;

  CarpetasModel({
    this.carpDescripcion,
    this.carpId,
  });

  factory CarpetasModel.fromJson(Map<String, dynamic> json) => CarpetasModel(
    carpDescripcion: json["CarpDescripcion"],
    carpId: json["CarpId"],
  );

  Map<String, dynamic> toJson() => {
    "CarpDescripcion": carpDescripcion,
    "CarpId": carpId,
  };
}



class Post {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  Post({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    albumId: json["albumId"],
    id: json["id"],
    title: json["title"],
    url: json["url"],
    thumbnailUrl: json["thumbnailUrl"],
  );

  Map<String, dynamic> toJson() => {
    "albumId": albumId,
    "id": id,
    "title": title,
    "url": url,
    "thumbnailUrl": thumbnailUrl,
  };
}
