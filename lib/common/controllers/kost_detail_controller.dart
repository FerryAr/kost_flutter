import 'package:get/get.dart';
import 'package:kost/common/services/kost_service.dart';
import 'package:kost/model/kost_detail_model.dart';

class KostDetailController extends GetxController {
  final _listKamar = <KostDetail>[].obs;
  final _idKost = ''.obs;
  final _namaKost = ''.obs;

  //getter
  List<KostDetail> get listKamar => _listKamar.toList();
  String get idKost => _idKost.value;
  String get namaKost => _namaKost.value;

  //setter
  set setDaftarKostDetail(List<KostDetail> value) =>
      _listKamar.assignAll(value);
  set setIdKost(String value) => _idKost.value = value;
  set setNamaKost(String value) => _namaKost.value = value;

  @override
  void onInit() {
    super.onInit();
    _idKost.value = Get.arguments['idKost'];
    _namaKost.value = Get.arguments['namaKost'];
    _getKostDetail(idKost);
  }

  void _getKostDetail(String idKost) async {
    setDaftarKostDetail =
        (await KostService().fetchDataKostDetail(idKost)).data;

    if (listKamar.isEmpty) {
      Get.snackbar('Gagal', 'Data Kosong',
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 10,
          snackStyle: SnackStyle.FLOATING,
          duration: const Duration(seconds: 2));
    }
  }
}
