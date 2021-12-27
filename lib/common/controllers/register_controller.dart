import 'package:get/state_manager.dart';
import 'package:kost/common/services/account_service.dart';

class RegisterController extends GetxController {
  register(Map<String, dynamic> formValue) async {
    final response = await AccountService().register(formValue);
    print(response);
  }
}
