import 'dart:convert';

Content contentFromJson(String str) => Content.fromJson(json.decode(str));

String contentToJson(Content data) => json.encode(data.toJson());

class Content {
  Content({
    required this.id,
    required this.module,
    required this.contentLink,
    required this.contentTitle,
    required this.name,
    required this.subjectId,
  });

  String id;
  String module;
  String contentLink;
  String contentTitle;
  String name;
  String subjectId;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        module: json["module"],
        contentLink: json["contentLink"],
        contentTitle: json["contentTitle"],
        name: json["name"],
        subjectId: json["subjectId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "module": module,
        "contentLink": contentLink,
        "contentTitle": contentTitle,
        "name": name,
        "subjectId": subjectId,
      };
}
