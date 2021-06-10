import 'dart:convert';

import 'package:dog_path_app/util/Utils.dart';

List<HomeData> homeDataDtoFromJson(String str) =>
    List<HomeData>.from(json.decode(str).map((x) => HomeData.fromMap(x)));

// String homeDataDtoToJson(List<HomeData> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeDataDto {
  List<HomeData> homeDataList;

  HomeDataDto({this.homeDataList});
  factory HomeDataDto.fromJson(String str) => HomeDataDto(
      homeDataList:
          str != null ? List<HomeData>.from(json.decode(str).map((x) => HomeData.fromMap(x))) : []);

  @override
  String toString() {
    return 'HomeDataDto{homeDataList: $homeDataList}';
  }
}

class HomeData {
  HomeData({
    this.id,
    this.title,
    this.subPaths,
    this.createdAt,
    this.name,
    this.avatar,
  });

  String id;
  String title;
  List<SubPath> subPaths;
  DateTime createdAt;
  String name;
  String avatar;

  factory HomeData.fromJson(String str) => HomeData.fromMap(json.decode(str));

  factory HomeData.fromMap(Map<String, dynamic> json) => HomeData(
        id: getFieldValue(json, "id"),
        title: getFieldValue(json, "title"),
        subPaths: !json.containsKey("sub_paths") || json["sub_paths"] == null
            ? []
            : List<SubPath>.from(json["sub_paths"].map((x) => SubPath.fromJson(x))),
        name: getFieldValue(json, "name"),
        avatar: getFieldValue(json, "avatar"),
      );

  @override
  String toString() {
    return 'HomeData{title: $title, subPaths: $subPaths, name: $name}';
  }
}

class SubPath {
  SubPath({
    this.id,
    this.title,
    this.image,
  });

  String id;
  String title;
  String image;

  factory SubPath.fromJson(Map<String, dynamic> json) => SubPath(
        id: json["id"],
        title: json["title"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
      };
}
