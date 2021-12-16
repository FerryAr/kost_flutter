import 'package:get/get.dart';
import 'package:kost/common/services/kost_service.dart';
import 'package:kost/model/kost_fasilitas_model.dart';

class KostFasilitasController extends GetxController {
  final _fasilitas = KostFasilitas().obs;
  final _idKost = ''.obs;

  //getter
  KostFasilitas get fasilitas => _fasilitas.value;
  String get idKost => _idKost.value;

  //setter
  set setFasilitas(KostFasilitas value) {
    _fasilitas.value = value;
  }

  set idKost(String value) => _idKost.value = value;

  @override
  void onInit() {
    super.onInit();
    idKost = Get.arguments['idKost'];
    getFasilitas(idKost);
  }

  void getFasilitas(idKost) async {
    setFasilitas = (await KostService().fetchDataFasilitasKost(idKost)).data;

    print(fasilitas);
  }
}
