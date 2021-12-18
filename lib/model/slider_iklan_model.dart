// To parse this JSON data, do
//
//     final sliderIklanModel = sliderIklanModelFromJson(jsonString);

import 'dart:convert';

SliderIklanModel sliderIklanModelFromJson(String str) =>
    SliderIklanModel.fromJson(json.decode(str));

String sliderIklanModelToJson(SliderIklanModel data) =>
    json.encode(data.toJson());

class SliderIklanModel {
  SliderIklanModel({
    this.status = '',
    required this.data,
  });

  String status;
  SliderIklan data;

  factory SliderIklanModel.fromJson(Map<String, dynamic> json) =>
      SliderIklanModel(
        status: json["status"],
        data: SliderIklan.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class SliderIklan {
  SliderIklan({
    this.fotoIklan = const [],
  });

  List<String> fotoIklan = [];

  factory SliderIklan.fromJson(Map<String, dynamic> json) => SliderIklan(
        fotoIklan: List<String>.from(json["foto_iklan"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "foto_iklan": List<dynamic>.from(fotoIklan.map((x) => x)),
      };
}
