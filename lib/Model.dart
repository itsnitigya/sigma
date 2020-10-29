// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.tags,
  });

  List<Tag> tags;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
      };
}

class Tag {
  Tag({
    // this.spaceList,
    this.id,
    this.title,
    this.displayName,
    this.meta,
    this.description,
    //this.v,
  });

  // List<dynamic> spaceList;
  String id = "";
  String title = "";
  String displayName = "";
  String meta = "";
  String description = "";
  // int v;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        //spaceList: List<dynamic>.from(json["spaceList"].map((x) => x)),
        id: json["_id"],
        title: json["title"],
        displayName: json["displayName"],
        meta: json["meta"] == null ? null : json["meta"],
        description: json["description"],
        // v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        // "spaceList": List<dynamic>.from(spaceList.map((x) => x)),
        "_id": id,
        "title": title,
        "displayName": displayName,
        "meta": meta == null ? null : meta,
        "description": description,
        // "__v": v,
      };
}
