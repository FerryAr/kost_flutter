import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kost/common/helper/get_storage_helper.dart';
import 'package:kost/common/services/account_service.dart';
import 'package:kost/model/login_data_model.dart';

class LoginController extends GetxController {
  final _akunData = AkunData().obs;
  final _loginStatus = LoginDataModel().obs;

  //getter
  AkunData get getAkunData => _akunData.value;
  LoginDataModel get getLoginStatus => _loginStatus.value;

  //setter
  set setAkunData(AkunData value) => _akunData.value = value;
  set setLoginStatus(LoginDataModel value) => _loginStatus.value = value;

  void loginProcess(String email, String password) async {
    if ((await AccountService().loginProcessService(email, password)).status ==
        "success") {
      setAkunData =
          (await AccountService().loginProcessService(email, password)).data!;
      GetStorageBox().box.write('isLoggedIn', true);
      GetStorageBox().box.write('userId', getAkunData.userId);
      GetStorageBox().box.write('userEmail', email);
      GetStorageBox().box.write('userFirstName', getAkunData.userFirstName);
      GetStorageBox().box.write('userNoWa', getAkunData.userNoWa);
      GetStorageBox().box.write('userAvatar', getAkunData.userAvatar);
      Get.offAllNamed('/');
      Fluttertoast.showToast(
        msg: (await AccountService().loginProcessService(email, password))
            .message,
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Fluttertoast.showToast(
        msg: (await AccountService().loginProcessService(email, password))
            .message,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
