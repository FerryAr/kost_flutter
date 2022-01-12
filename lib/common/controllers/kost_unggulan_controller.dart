import 'package:get/get.dart';
import 'package:kost/common/services/kost_service.dart';
import 'package:kost/model/kost_by_jenis.dart';

class KostUnggulan extends GetxController {
  final _daftarKost = <Kost>[].obs;

  List<Kost> get getKostUnggulan => _daftarKost.toList();

  set setKostUnggulan(List<Kost> value) {
    _daftarKost.assignAll(value);
  }

  @override
  void onInit() {
    super.onInit();
    getDataKostUnggulan();
  }

  void getDataKostUnggulan() async {
    setKostUnggulan = (await KostService().fetchDataKostUnggulan()).data;
  }
}
