// To parse this JSON data, do
//
//     final blogByIdModel = blogByIdModelFromJson(jsonString);

import 'dart:convert';

BlogByIdModel blogByIdModelFromJson(String str) =>
    BlogByIdModel.fromJson(json.decode(str));

String blogByIdModelToJson(BlogByIdModel data) => json.encode(data.toJson());

class BlogByIdModel {
  BlogByIdModel({
    this.status = '',
    required this.data,
  });

  String status;
  Blog data;

  factory BlogByIdModel.fromJson(Map<String, dynamic> json) => BlogByIdModel(
        status: json["status"],
        data: Blog.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Blog {
  Blog({
    this.id = '',
    this.thumbnail = '',
    this.kategori = '',
    this.judul = '',
    this.isi = '',
    this.dibuatPada = '',
  });

  String id;
  String thumbnail;
  String kategori;
  String judul;
  String isi;
  String dibuatPada;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
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
