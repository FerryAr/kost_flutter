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
    this.idKost = '',
    this.namaKost = '',
    this.pemilik = '',
    this.alamat = '',
    this.noHp = '',
    this.jenisId = '',
    this.jenis = '',
    this.type = '',
    this.harga = '0',
    this.dataOperator = '',
    this.operatorLastLogin = '',
    this.operatorLastLogout = '',
    //this.operatorLoginStatus = '',
    this.operatorAvatar = '',
    this.foto = const [],
    this.areaTerdekat = '',
    this.unggulan = '',
  });

  String idKost;
  String namaKost;
  String pemilik;
  String alamat;
  String noHp;
  String jenisId;
  String jenis;
  String type;
  String harga;
  String dataOperator;
  String operatorAvatar;
  String operatorLastLogin;
  String operatorLastLogout;
  //String operatorLoginStatus;
  List<String> foto = [];
  String areaTerdekat;
  String unggulan;

  factory KostById.fromJson(Map<String, dynamic> json) => KostById(
        idKost: json["id_kost"],
        namaKost: json["nama_kost"],
        pemilik: json["pemilik"],
        alamat: json["alamat"],
        noHp: json["no_hp"],
        jenisId: json["jenis_id"],
        jenis: json["jenis"],
        type: json["type"],
        harga: json["harga"],
        dataOperator: json['operator'],
        operatorAvatar: json['operator_avatar'],
        operatorLastLogin: json['operator_last_login'],
        operatorLastLogout: json['operator_last_logout'],
        //operatorLoginStatus: json['operator_login_status'],
        foto: List<String>.from(json["foto"].map((x) => x)),
        areaTerdekat: json["area_terdekat"],
        unggulan: json["unggulan"],
      );

  Map<String, dynamic> toJson() => {
        "id_kost": idKost,
        "nama_kost": namaKost,
        "pemilik": pemilik,
        "alamat": alamat,
        "no_hp": noHp,
        "jenis_id": jenisId,
        "jenis": jenis,
        "type": type,
        "harga": harga,
        "operator": dataOperator,
        "foto": List<dynamic>.from(foto.map((x) => x)),
        "area_terdekat": areaTerdekat,
        "unggulan": unggulan,
      };
}
