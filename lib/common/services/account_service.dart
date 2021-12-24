import 'package:get/get.dart';
import 'package:kost/model/login_data_model.dart';

const baseUrl = "http://192.168.19.82";
const apiKey = "691ACB";

class AccountService extends GetConnect {
  Future<LoginDataModel> loginProcessService(
      String email, String password) async {
    final response = await post(
        "$baseUrl/kost/api/login",
        FormData({
          "apiKey": apiKey,
          "email": email,
          "password": password,
        }));
    print(response.body['data'] == []);
    if (response.statusCode == 200) {
      return LoginDataModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
