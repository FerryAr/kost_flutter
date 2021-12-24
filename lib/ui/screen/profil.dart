import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kost/common/controllers/login_controller.dart';
import 'package:kost/common/helper/get_storage_helper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();

  bool loggedIn = false;

  @override
  void dispose() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black54,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: GetStorageBox().box.read('isLoggedIn') == false
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/img/blank-avatar.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 5.0),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: Text('LOGIN'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TextField(
                                    controller: emailLoginController,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.email),
                                      labelText: 'Email',
                                    ),
                                  ),
                                  TextField(
                                    obscureText: true,
                                    controller: passwordLoginController,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.lock),
                                      labelText: 'Password',
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                DialogButton(
                                  onPressed: () {
                                    emailLoginController.text != '' &&
                                            passwordLoginController.text != ''
                                        ? LoginController().loginProcess(
                                            emailLoginController.text,
                                            passwordLoginController.text)
                                        : Get.snackbar(
                                            "Error",
                                            "Email dan Password tidak boleh kosong",
                                            borderRadius: 10,
                                            snackPosition: SnackPosition.BOTTOM,
                                            duration:
                                                const Duration(seconds: 5),
                                          );
                                  },
                                  child: const Text(
                                    "LOGIN",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                )
                              ],
                            );
                          });
                      // Alert(
                      //     context: context,
                      //     useRootNavigator: false,
                      //     title: "LOGIN",
                      //     content: Column(
                      //       children: <Widget>[
                      //         TextField(
                      //           controller: emailLoginController,
                      //           decoration: const InputDecoration(
                      //             icon: Icon(Icons.email),
                      //             labelText: 'Email',
                      //           ),
                      //         ),
                      //         TextField(
                      //           obscureText: true,
                      //           controller: passwordLoginController,
                      //           decoration: const InputDecoration(
                      //             icon: Icon(Icons.lock),
                      //             labelText: 'Password',
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     buttons: [
                      //       DialogButton(
                      //         onPressed: () {
                      //           emailLoginController.text != '' &&
                      //                   passwordLoginController.text != ''
                      //               ? LoginController().loginProcess(
                      //                   emailLoginController.text,
                      //                   passwordLoginController.text)
                      //               : Get.snackbar(
                      //                   "Error",
                      //                   "Email dan Password tidak boleh kosong",
                      //                   borderRadius: 10,
                      //                   snackPosition: SnackPosition.BOTTOM,
                      //                   duration: const Duration(seconds: 5),
                      //                 );
                      //         },
                      //         child: const Text(
                      //           "LOGIN",
                      //           style: TextStyle(
                      //               color: Colors.white, fontSize: 20),
                      //         ),
                      //       )
                      //     ]).show();
                    },
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.person,
                          size: 40,
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.app_registration,
                        size: 40,
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  const Divider(
                    thickness: 2,
                  ),
                  // Center(
                  //   child: Text("Aplikasi Kost"),
                  //   ),
                ],
              ),
            ),
    );
  }
}
