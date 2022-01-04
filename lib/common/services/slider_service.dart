import 'package:get/get.dart';
import 'package:kost/model/slider_iklan_model.dart';

const baseUrl = "https://kost.diengcyber.com";
const apiKey = "691ACB";

class SliderService extends GetConnect {
  Future<SliderIklanModel> fetchSlider() async {
    final response =
        await post('$baseUrl/api/get_slider', FormData({'apiKey': apiKey}));

    if (response.statusCode == 200) {
      return SliderIklanModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
