// To parse this JSON data, do
//
//     final kostByIdModel = kostByIdModelFromJson(jsonString);

import 'dart:convert';

KostByIdModel kostByIdModelFromJson(String str) =>
    KostByIdModel.fromJson(json.decode(str));

String kostByIdModelToJson(KostByIdModel data) => json.encode(data.toJson());

class KostByIdModel {
  KostByIdModel({
    this.status = '',
    required this.data,
  });

  String status;
  KostById data;

  factory KostByIdModel.fromJson(Map<String, dynamic> json) => KostByIdModel(
        status: json["status"],
        data: KostById.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class KostById {
  KostById({
    this.id = '',
    this.namaKost = '',
    this.pemilik = '',
    this.alamat = '',
    this.noHp = '',
    this.jenis = '',
    this.type = '',
    this.areaTerdekat = '',
    this.fotoUnggulan = '',
  });

  String id;
  String namaKost;
  String pemilik;
  String alamat;
  String noHp;
  String jenis;
  String type;
  String areaTerdekat;
  String fotoUnggulan;

  factory KostById.fromJson(Map<String, dynamic> json) => KostById(
        id: json["id"],
        namaKost: json["nama_kost"],
        pemilik: json["pemilik"],
        alamat: json["alamat"],
        noHp: json["no_hp"],
        jenis: json["jenis"],
        type: json['type'],
        areaTerdekat: json["area_terdekat"],
        fotoUnggulan: json["foto_unggulan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_kost": namaKost,
        "pemilik": pemilik,
        "alamat": alamat,
        "no_hp": noHp,
        "jenis": jenis,
        'type': type,
        "area_terdekat": areaTerdekat,
        "foto_unggulan": fotoUnggulan,
      };
}
