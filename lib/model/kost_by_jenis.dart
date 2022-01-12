// To parse this JSON data, do
//
//     final kostByJenis = kostByJenisFromJson(jsonString);

import 'dart:convert';

KostByJenis kostByJenisFromJson(String str) =>
    KostByJenis.fromJson(json.decode(str));

String kostByJenisToJson(KostByJenis data) => json.encode(data.toJson());

class KostByJenis {
  KostByJenis({
    this.status = '',
    required this.data,
  });

  String status;
  List<Kost> data;

  factory KostByJenis.fromJson(Map<String, dynamic> json) => KostByJenis(
        status: json["status"],
        data: List<Kost>.from(json["data"].map((x) => Kost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Kost {
  Kost({
    this.idKost = '',
    this.namaKost = '',
    this.pemilik = '',
    this.alamat = '',
    this.jenisId = '',
    this.jenis = '',
    this.type = '',
    this.harga = '',
    this.areaTerdekat = '',
    this.foto = '',
  });

  String idKost;
  String namaKost;
  String pemilik;
  String alamat;
  String jenisId;
  String jenis;
  String type;
  String harga;
  String areaTerdekat;
  String foto;

  factory Kost.fromJson(Map<String, dynamic> json) => Kost(
        idKost: json["id_kost"],
        namaKost: json["nama_kost"],
        //pemilik: json["pemilik"],
        alamat: json["alamat"],
        jenisId: json["jenis_id"],
        jenis: json["jenis"],
        type: json["type"],
        harga: json["harga"],
        areaTerdekat: json["area_terdekat"],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "id_kost": idKost,
        "nama_kost": namaKost,
        //"pemilik": pemilik,
        "alamat": alamat,
        "jenis_id": jenisId,
        "jenis": jenis,
        "type": type,
        "harga": harga,
        "area_terdekat": areaTerdekat,
        "foto": foto,
      };
}
