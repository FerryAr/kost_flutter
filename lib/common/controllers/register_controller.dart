import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kost/common/services/account_service.dart';
import 'package:kost/model/register_model.dart';

class RegisterController extends GetxController {
  final _registerMessage = RegisterModel().message.obs;

  String get getRegisterMessage => _registerMessage.value;

  set setRegisterMessage(String value) => _registerMessage.value = value;

  registerProcess(Map<String, dynamic> formValue, BuildContext context) async {
    final response = await AccountService().registerProcessService(formValue);
    String registerStatus = response.status;
    setRegisterMessage = response.message;
    if (registerStatus == 'success') {
      Fluttertoast.showToast(
        msg: getRegisterMessage,
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
        msg: getRegisterMessage,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
