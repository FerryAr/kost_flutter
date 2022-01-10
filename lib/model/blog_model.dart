import 'dart:convert';

BlogModel blogModelFromJson(String str) => BlogModel.fromJson(json.decode(str));

String blogModelToJson(BlogModel data) => json.encode(data.toJson());

class BlogModel {
  BlogModel({
    this.status = '',
    required this.data,
  });

  String status;
  List<BlogData> data;

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        status: json["status"],
        data:
            List<BlogData>.from(json["data"].map((x) => BlogData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BlogData {
  BlogData({
    required this.id,
    required this.thumbnail,
    required this.kategori,
    required this.judul,
    required this.isi,
    required this.dibuatPada,
  });

  String id;
  String thumbnail;
  String kategori;
  String judul;
  String isi;
  String dibuatPada;

  factory BlogData.fromJson(Map<String, dynamic> json) => BlogData(
        id: json["id"],
        thumbnail: json["thumbnail"],
        kategori: json["kategori"],
        judul: json["judul"],
        isi: json["isi"],
        dibuatPada: json["dibuat_pada"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "thumbnail": thumbnail,
        "kategori": kategori,
        "judul": judul,
        "isi": isi,
        "dibuat_pada": dibuatPada,
      };
}
