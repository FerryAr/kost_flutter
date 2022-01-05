import 'dart:convert';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:kost/model/login_data_model.dart';
import 'package:kost/model/register_model.dart';
import 'package:kost/model/logout_model.dart';

const baseUrl = "https://kost.diengcyber.com";
const apiKey = "691ACB";

class AccountService extends GetConnect {
  Future<RegisterModel> registerProcessService(
      Map<String, dynamic> form) async {
    String fileName = "name";
    String filePath = "path";
    for (XFile img in form["avatar"]) {
      fileName = img.name;
      filePath = img.path;
    }
    //print(fileName);
    final request =
        http.MultipartRequest("POST", Uri.parse("$baseUrl/api/register"));
    request.fields['apiKey'] = apiKey;
    request.fields['first_name'] = form["first_name"];
    request.fields['last_name'] = form["last_name"];
    request.fields['email'] = form["email"];
    request.fields['password'] = form["password"];
    request.fields['no_wa'] = form["no_wa"];
    request.files.add(await http.MultipartFile.fromPath("avatar", filePath,
        filename: fileName));

    http.StreamedResponse response = await request.send();
    var responseJson = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return RegisterModel.fromJson(json.decode(responseJson));
    } else {
      throw Exception('Failed to load post');
    }
    // final response = await post(
    //     "https://webhook.site/d4790a82-d0b1-4824-9d71-fe03a70bbbb6",
    //     FormData({
    //       "apiKey": apiKey,
    //       "first_name": form["first_name"],
    //       "last_name": form["last_name"],
    //       "email": form["email"],
    //       "password": form["password"],
    //       "no_wa": form["no_wa"],
    //       "avatar": MultipartFile('file', stream, length, filename: fileName),
    //     }));
    // print(response.statusCode);
    // if (response.statusCode == 200) {
    //   return RegisterModel.fromJson(response.body);
    // } else {
    //   throw Exception('Failed to load post');
    // }
  }

  Future<LoginDataModel> loginProcessService(
      String email, String password) async {
    final response = await post(
        "$baseUrl/api/login",
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
        "$baseUrl/api/logout",
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
