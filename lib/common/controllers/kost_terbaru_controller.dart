import 'package:get/get.dart';
import 'package:kost/common/services/kost_service.dart';
import 'package:kost/model/kost_by_jenis.dart';

class KostTerbaruController extends GetxController {
  final _kostTerbaru = <Kost>[].obs;

  //getter
  List<Kost> get getKostTerbaru => _kostTerbaru.toList();

  //setter
  set setKostTerbaru(List<Kost> value) {
    _kostTerbaru.assignAll(value);
  }

  @override
  void onInit() {
    super.onInit();
    getDataKostTerbaru();
  }

  void getDataKostTerbaru() async {
    setKostTerbaru = (await KostService().fetchDataKostTerbaru()).data;
  }
}
