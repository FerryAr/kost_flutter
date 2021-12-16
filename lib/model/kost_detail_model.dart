// To parse this JSON data, do
//
//     final kostDetailModel = kostDetailModelFromJson(jsonString);

import 'dart:convert';

KostDetailModel kostDetailModelFromJson(String str) =>
    KostDetailModel.fromJson(json.decode(str));

String kostDetailModelToJson(KostDetailModel data) =>
    json.encode(data.toJson());

class KostDetailModel {
  KostDetailModel({
    this.status = '',
    required this.data,
  });

  String status;
  List<KostDetail> data;

  factory KostDetailModel.fromJson(Map<String, dynamic> json) =>
      KostDetailModel(
        status: json["status"],
        data: List<KostDetail>.from(
            json["data"].map((x) => KostDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class KostDetail {
  KostDetail({
    this.id = '',
    this.namaKamar = '',
    this.deskripsiKamar = '',
    this.harga = '',
    this.fasilitas = '',
    this.foto = '',
  });

  String id;
  String namaKamar;
  String deskripsiKamar;
  String harga;
  String fasilitas;
  String foto;

  factory KostDetail.fromJson(Map<String, dynamic> json) => KostDetail(
        id: json["id"],
        namaKamar: json["nama_kamar"],
        deskripsiKamar: json["deskripsi_kamar"],
        harga: json["harga"],
        fasilitas: json["fasilitas"],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_kamar": namaKamar,
        "deskripsi_kamar": deskripsiKamar,
        "harga": harga,
        "fasilitas": fasilitas,
        "foto": foto,
      };
}
