import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:kost/common/controllers/register_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: FormBuilder(
              key: formKey,
              child: Column(
                children: [
                  FormBuilderImagePicker(
                    name: 'avatar',
                    maxImages: 1,
                    decoration: const InputDecoration(labelText: 'Foto Profil'),
                    validator: FormBuilderValidators.required(context),
                  ),
                  const SizedBox(height: 8),
                  FormBuilderTextField(
                      name: 'first_name',
                      decoration: inputDecoration('Nama Depan', Icons.person),
                      validator: FormBuilderValidators.required(context)),
                  const SizedBox(height: 8),
                  FormBuilderTextField(
                      name: 'last_name',
                      decoration:
                          inputDecoration('Nama Belakang', Icons.person),
                      validator: FormBuilderValidators.required(context)),
                  const SizedBox(height: 8),
                  FormBuilderTextField(
                      name: 'no_wa',
                      decoration: inputDecoration('No. Wa', MdiIcons.whatsapp),
                      validator: FormBuilderValidators.required(context)),
                  const SizedBox(height: 8),
                  FormBuilderTextField(
                      name: 'email',
                      decoration: inputDecoration('Email', Icons.email),
                      validator: FormBuilderValidators.required(context)),
                  const SizedBox(height: 8),
                  FormBuilderTextField(
                      name: 'password',
                      obscureText: true,
                      decoration: inputDecoration('Password', Icons.lock),
                      validator: FormBuilderValidators.required(context)),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                        child: const Text('Register'),
                        color: Colors.blue,
                        onPressed: () {
                          formKey.currentState!.saveAndValidate();
                          RegisterController()
                              .register(formKey.currentState!.value);
                        }),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
