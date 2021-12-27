import 'package:get/get.dart';
import 'package:kost/common/helper/get_storage_helper.dart';
import 'package:kost/common/services/account_service.dart';
import 'package:kost/model/logout_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LogoutController extends GetxController {
  final _logoutMessage = LogoutModel().message.obs;

  String get getLogoutMessage => _logoutMessage.value;

  set setLogoutMessage(String value) => _logoutMessage.value = value;

  void logoutProcess(String userId) async {
    if ((await AccountService().logoutProcessService(userId)).status ==
        "success") {
      setLogoutMessage =
          (await AccountService().logoutProcessService(userId)).message;
      GetStorageBox().box.erase();
      Get.offAllNamed('/');
      Fluttertoast.showToast(
        msg: getLogoutMessage,
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Get.offAllNamed('/');
      Fluttertoast.showToast(
        msg: "Logout Gagal",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
