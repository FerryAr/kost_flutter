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
        status: json["status"] == null ? null : json["status"],
        data: List<KostDetail>.from(
            json["data"].map((x) => KostDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
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
        id: json["id"] == null ? null : json["id"],
        namaKamar: json["nama_kamar"] == null ? null : json["nama_kamar"],
        deskripsiKamar:
            json["deskripsi_kamar"] == null ? null : json["deskripsi_kamar"],
        harga: json["harga"] == null ? null : json["harga"],
        fasilitas: json["fasilitas"] == null ? null : json["fasilitas"],
        foto: json["foto"] == null ? null : json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nama_kamar": namaKamar == null ? null : namaKamar,
        "deskripsi_kamar": deskripsiKamar == null ? null : deskripsiKamar,
        "harga": harga == null ? null : harga,
        "fasilitas": fasilitas == null ? null : fasilitas,
        "foto": foto == null ? null : foto,
      };
}
