import 'dart:convert';

Module moduleFromJson(String str) => Module.fromJson(json.decode(str));

String moduleToJson(Module data) => json.encode(data.toJson());

class Module {
  Module({
    required this.id,
    required this.subject,
    required this.moduleName,
  });

  String id;
  String subject;
  String moduleName;

  factory Module.fromJson(Map<String, dynamic> json) => Module(
        id: json["id"],
        subject: json["subject"],
        moduleName: json["moduleName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "moduleName": moduleName,
      };
}
