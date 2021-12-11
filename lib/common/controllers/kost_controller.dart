import 'package:get/get.dart';
import 'package:kost/common/services/kost_service.dart';
import 'package:kost/model/kost_by_jenis.dart';

class KostController extends GetxController {
  final _daftarKost = <Kost>[].obs;
  final _namaJenis = ''.obs;
  final _idJenis = ''.obs;

  //getter
  List<Kost> get daftarKost => _daftarKost.toList();
  String get namaJenis => _namaJenis.value;
  String get idJenis => _idJenis.value;

  //setter
  set setDaftarKost(List<Kost> value) {
    _daftarKost.assignAll(value);
  }

  set namaJenis(String value) => _namaJenis.value = value;
  set idJenis(String value) => _idJenis.value = value;

  @override
  void onInit() {
    super.onInit();

    namaJenis = Get.arguments['namaJenis'];
    idJenis = Get.arguments['idJenis'];

    getDataKostJenis(idJenis);
  }

  void getDataKostJenis(String idJenis) async {
    // try {
    setDaftarKost = (await KostService().fetchDataKostJenis(idJenis)).data;
    if (daftarKost.isEmpty) {
      Get.snackbar('Oops', 'Data Kosong',
          snackPosition: SnackPosition.BOTTOM,
          //backgroundColor: Colors.red,
          borderRadius: 10,
          //margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: const Duration(seconds: 2));
    }
    // } catch (e) {
    //   print(e);
    // }
  }
}
