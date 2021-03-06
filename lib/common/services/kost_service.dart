import 'package:get/get.dart';
import 'package:kost/model/kost_by_id_model.dart';
import 'package:kost/model/kost_by_jenis.dart';
import 'package:kost/model/kost_detail_model.dart';
import 'package:kost/model/kost_fasilitas_model.dart';

const baseUrl = "https://kost.diengcyber.com";
const apiKey = "691ACB";

class KostService extends GetConnect {
  Future<KostByJenis> fetchDataKostJenis(String idJenis) async {
    final response = await post("$baseUrl/api/get_kost_by_jenis",
        FormData({'apiKey': apiKey, 'jenis': idJenis}));

    if (response.statusCode == 200) {
      return KostByJenis.fromJson(response.body);
    } else {
      throw Exception('an error occured');
    }
  }

  Future<KostByIdModel> fetchDataKostById(String idKost) async {
    final response = await post(
        "$baseUrl/api/get_kost", FormData({'apiKey': apiKey, 'id': idKost}));

    if (response.statusCode == 200) {
      return KostByIdModel.fromJson(response.body);
    } else {
      throw Exception('an error occured');
    }
  }

  Future<KostDetailModel> fetchDataKostDetail(String idKost) async {
    final response = await post("$baseUrl/api/get_kost_detail",
        FormData({'apiKey': apiKey, 'id_kost': idKost}));

    if (response.statusCode == 200) {
      return KostDetailModel.fromJson(response.body);
    } else {
      throw Exception('an error occured');
    }
  }

  Future<KostFasilitasModel> fetchDataFasilitasKost(String idKost) async {
    final response = await post("$baseUrl/api/get_fasilitas",
        FormData({'apiKey': apiKey, 'id_kost': idKost}));

    if (response.statusCode == 200) {
      return KostFasilitasModel.fromJson(response.body);
    } else {
      throw Exception('an error occured');
    }
  }

  Future<KostByJenis> fetchDataKostInput(String input) async {
    final response = await post("$baseUrl/api/get_kost_by_input",
        FormData({'apiKey': apiKey, 'input': input}));

    if (response.statusCode == 200) {
      return KostByJenis.fromJson(response.body);
    } else {
      throw Exception('an error occured');
    }
  }

  Future<KostByJenis> fetchDataKostUnggulan() async {
    final response = await post(
        "$baseUrl/api/get_kost_unggulan", FormData({'apiKey': apiKey}));

    if (response.statusCode == 200) {
      return KostByJenis.fromJson(response.body);
    } else {
      throw Exception('an error occured');
    }
  }

  Future<KostByJenis> fetchDataKostTerbaru() async {
    final response = await post(
        "$baseUrl/api/get_kost_terbaru", FormData({'apiKey': apiKey}));

    if (response.statusCode == 200) {
      return KostByJenis.fromJson(response.body);
    } else {
      throw Exception('an error occured');
    }
  }
}
