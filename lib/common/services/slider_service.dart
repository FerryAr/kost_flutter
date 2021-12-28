import 'package:get/get.dart';
import 'package:kost/model/slider_iklan_model.dart';

const baseUrl = "http://192.168.157.242";
const apiKey = "691ACB";

class SliderService extends GetConnect {
  Future<SliderIklanModel> fetchSlider() async {
    final response = await post(
        '$baseUrl/kost/api/get_slider', FormData({'apiKey': apiKey}));

    if (response.statusCode == 200) {
      return SliderIklanModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
