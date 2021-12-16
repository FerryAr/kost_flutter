import 'package:get/get.dart';
import 'package:kost/common/services/kost_service.dart';
import 'package:kost/model/kost_by_id_model.dart';

class KostByIdController extends GetxController {
  // ignore: non_constant_identifier_names
  final _kost = KostById().obs;
  final _idKost = ''.obs;

  //getter
  KostById get kost => _kost.value;
  String get idKost => _idKost.value;

  //setter
  set setKost(KostById value) {
    _kost.value = value;
  }

  set idKost(String value) => _idKost.value = value;

  @override
  void onInit() {
    super.onInit();

    idKost = Get.arguments['idKost'];
    getKost(idKost);
  }

  void getKost(String idKost) async {
    setKost = (await KostService().fetchDataKostById(idKost)).data;
    print(kost.foto.length);
  }
}
