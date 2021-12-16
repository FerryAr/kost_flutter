import 'package:get/get.dart';
import 'package:kost/common/services/kost_service.dart';
import 'package:kost/model/kost_by_jenis.dart';

class KostByInputController extends GetxController {
  final _daftarKost = <Kost>[].obs;
  final _input = ''.obs;

  List<Kost> get daftarKost => _daftarKost.toList();
  String get input => _input.value;

  set setDaftarKost(List<Kost> value) {
    _daftarKost.assignAll(value);
  }

  set setInput(String value) => _input.value = value;

  @override
  void onInit() {
    super.onInit();
    getDataKostInput(input);
  }

  void getDataKostInput(String input) async {
    setDaftarKost = (await KostService().fetchDataKostInput(input)).data;
    print(input);
  }
}
