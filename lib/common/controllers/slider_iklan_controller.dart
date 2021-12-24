import 'package:get/get.dart';
import 'package:kost/common/services/slider_service.dart';
import 'package:kost/model/slider_iklan_model.dart';

class SliderController extends GetxController {
  final _slider = SliderIklan().obs;

  //getter
  SliderIklan get slider => _slider.value;

  //setter
  set setSlider(SliderIklan value) {
    _slider.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    getSlider();
  }

  void getSlider() async {
    setSlider = (await SliderService().fetchSlider()).data;
  }
}
