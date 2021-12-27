import 'package:get/get.dart';
import 'package:kost/model/login_data_model.dart';
import 'package:kost/model/logout_model.dart';

const baseUrl = "http://192.168.119.9";
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
    if (response.statusCode == 200) {
      return LoginDataModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<LogoutModel> logoutProcessService(String userId) async {
    final response = await post(
        "$baseUrl/kost/api/logout",
        FormData({
          "apiKey": apiKey,
          "user_id": userId,
        }));
    if (response.statusCode == 200) {
      return LogoutModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
