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
        status: json["status"] == null ? null : json["status"],
        data: List<Kost>.from(json["data"].map((x) => Kost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Kost {
  Kost({
    this.idKost = '',
    this.namaKost = '',
    this.pemilik = '',
    this.alamat = '',
    this.noHp = '',
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
  String noHp;
  String jenis;
  String type;
  String harga;
  String areaTerdekat;
  String foto;

  factory Kost.fromJson(Map<String, dynamic> json) => Kost(
        idKost: json["id_kost"] == null ? null : json["id_kost"],
        namaKost: json["nama_kost"] == null ? null : json["nama_kost"],
        pemilik: json["pemilik"] == null ? null : json["pemilik"],
        alamat: json["alamat"] == null ? null : json["alamat"],
        noHp: json["no_hp"] == null ? null : json["no_hp"],
        jenis: json["jenis"] == null ? null : json["jenis"],
        type: json["type"] == null ? null : json["type"],
        harga: json["harga"] == null ? null : json["harga"],
        areaTerdekat:
            json["area_terdekat"] == null ? null : json["area_terdekat"],
        foto: json["foto"] == null ? null : json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "id_kost": idKost == null ? null : idKost,
        "nama_kost": namaKost == null ? null : namaKost,
        "pemilik": pemilik == null ? null : pemilik,
        "alamat": alamat == null ? null : alamat,
        "no_hp": noHp == null ? null : noHp,
        "jenis": jenis == null ? null : jenis,
        "type": type == null ? null : type,
        "harga": harga == null ? null : harga,
        "area_terdekat": areaTerdekat == null ? null : areaTerdekat,
        "foto": foto == null ? null : foto,
      };
}
