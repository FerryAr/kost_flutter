import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kost/common/controllers/login_controller.dart';
import 'package:kost/common/controllers/logout_controller.dart';
import 'package:kost/common/helper/get_storage_helper.dart';
//import 'package:kost/ui/screen/register.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:kost/common/controllers/register_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

const baseUrl = "http://192.168.157.242/kost";

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
  final formKey = GlobalKey<FormBuilderState>();

  inputDecoration(String label, IconData icon) {
    return InputDecoration(
      isDense: true,
      label: Text(label),
      prefixIcon: Icon(
        icon,
        color: Colors.black,
      ),
      enabledBorder: const UnderlineInputBorder(),
      border: const UnderlineInputBorder(),
    );
  }

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
                            return Scaffold(
                              appBar: AppBar(
                                title: const Text('Register'),
                              ),
                              body: SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  child: FormBuilder(
                                      autovalidateMode:
                                          AutovalidateMode.disabled,
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          FormBuilderImagePicker(
                                            name: 'avatar',
                                            maxImages: 1,
                                            decoration: const InputDecoration(
                                                labelText: 'Foto Profil'),
                                            validator:
                                                FormBuilderValidators.required(
                                                    context),
                                          ),
                                          const SizedBox(height: 8),
                                          FormBuilderTextField(
                                              name: 'first_name',
                                              decoration: inputDecoration(
                                                  'Nama Depan', Icons.person),
                                              validator: FormBuilderValidators
                                                  .required(context)),
                                          const SizedBox(height: 8),
                                          FormBuilderTextField(
                                              name: 'last_name',
                                              decoration: inputDecoration(
                                                  'Nama Belakang',
                                                  Icons.person),
                                              validator: FormBuilderValidators
                                                  .required(context)),
                                          const SizedBox(height: 8),
                                          FormBuilderTextField(
                                              name: 'no_wa',
                                              decoration: inputDecoration(
                                                  'No. Wa', MdiIcons.whatsapp),
                                              validator: FormBuilderValidators
                                                  .required(context)),
                                          const SizedBox(height: 8),
                                          FormBuilderTextField(
                                              name: 'email',
                                              decoration: inputDecoration(
                                                  'Email', Icons.email),
                                              validator: FormBuilderValidators
                                                  .required(context)),
                                          const SizedBox(height: 8),
                                          FormBuilderTextField(
                                              name: 'password',
                                              obscureText: true,
                                              decoration: inputDecoration(
                                                  'Password', Icons.lock),
                                              validator: FormBuilderValidators
                                                  .required(context)),
                                          const SizedBox(height: 16),
                                          SizedBox(
                                            width: double.infinity,
                                            child: CupertinoButton(
                                                child: const Text('Register'),
                                                color: Colors.blue,
                                                onPressed: () {
                                                  if (formKey.currentState!
                                                      .saveAndValidate()) {
                                                    RegisterController()
                                                        .registerProcess(
                                                            formKey
                                                                .currentState!
                                                                .value,
                                                            dialogContext);
                                                  } else {}
                                                }),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            );
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
