import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kost/common/controllers/login_controller.dart';
import 'package:kost/common/controllers/logout_controller.dart';
import 'package:kost/common/helper/get_storage_helper.dart';
import 'package:kost/ui/screen/register.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cached_network_image/cached_network_image.dart';

const baseUrl = "http://192.168.119.9/kost";

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  //login
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();

  //register
  final firstNameRegisterController = TextEditingController();
  final lastNameRegisterController = TextEditingController();
  final emailRegisterController = TextEditingController();
  final passwordRegisterController = TextEditingController();

  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
  }

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
      body: GetStorageBox().box.read('isLoggedIn') == true
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CachedNetworkImage(
                        imageUrl:
                            "$baseUrl/assets/img/avatars/${GetStorageBox().box.read('userAvatar')}",
                        imageBuilder: (context, imageProvider) => Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                        fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      GetStorageBox().box.read('userFirstName'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      GetStorageBox().box.read('userEmail'),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // const Divider(
                  //   thickness: 2,
                  // ),
                  // const SizedBox(height: 5.0),
                  // Row(
                  //   children: const [
                  //     Icon(
                  //       Icons.shopping_cart,
                  //       size: 30,
                  //     ),
                  //     SizedBox(width: 15),
                  //     Text(
                  //       "Keranjang",
                  //       style: TextStyle(
                  //         fontSize: 18,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 5.0),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: const [
                      Icon(
                        Icons.edit,
                        size: 30,
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Edit Profil",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 5.0),
                  InkWell(
                    onTap: () {
                      LogoutController()
                          .logoutProcess(GetStorageBox().box.read('userId'));
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.exit_to_app,
                          size: 30,
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
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
                              title: const Text('LOGIN'),
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
                                            passwordLoginController.text,
                                          )
                                        : Fluttertoast.showToast(
                                            msg:
                                                'Email dan Password tidak boleh kosong',
                                            toastLength: Toast.LENGTH_SHORT,
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
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return RegisterPage();
                            // return WebView(
                            //   initialUrl: '$baseUrl/auth/create_user',
                            // );
                            // return AlertDialog(
                            //   title: const Text('REGISTER'),
                            //   content: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: <Widget>[
                            //       TextField(
                            //         controller: firstNameRegisterController,
                            //         decoration: const InputDecoration(
                            //           icon: Icon(Icons.person),
                            //           labelText: 'Nama Depan',
                            //         ),
                            //       ),
                            //       TextField(
                            //         controller: lastNameRegisterController,
                            //         decoration: const InputDecoration(
                            //           icon: Icon(Icons.person),
                            //           labelText: 'Nama Belakang',
                            //         ),
                            //       ),
                            //       TextField(
                            //         controller: emailRegisterController,
                            //         decoration: const InputDecoration(
                            //           icon: Icon(Icons.email),
                            //           labelText: 'Email',
                            //         ),
                            //       ),
                            //       TextField(
                            //         obscureText: true,
                            //         controller: passwordRegisterController,
                            //         decoration: const InputDecoration(
                            //           icon: Icon(Icons.lock),
                            //           labelText: 'Password',
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            //   actions: [
                            //     DialogButton(
                            //       onPressed: () {
                            //         emailLoginController.text != '' &&
                            //                 passwordLoginController.text != ''
                            //             ? LoginController().loginProcess(
                            //                 emailLoginController.text,
                            //                 passwordLoginController.text,
                            //               )
                            //             : Fluttertoast.showToast(
                            //                 msg:
                            //                     'Email dan Password tidak boleh kosong',
                            //                 toastLength: Toast.LENGTH_SHORT,
                            //               );
                            //       },
                            //       child: const Text(
                            //         "REGISTER",
                            //         style: TextStyle(
                            //             color: Colors.white, fontSize: 20),
                            //       ),
                            //     )
                            //   ],
                            // );
                          });
                    },
                    child: Row(
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
