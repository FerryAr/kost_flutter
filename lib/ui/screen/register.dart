import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

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
                    name: 'image',
                    maxImages: 1,
                    decoration: const InputDecoration(labelText: 'Foto Profil'),
                  ),
                  const SizedBox(height: 8),
                  FormBuilderTextField(
                    name: 'first_name',
                    decoration: inputDecoration('Nama Depan', Icons.person),
                  ),
                  const SizedBox(height: 8),
                  FormBuilderTextField(
                      name: 'last_name',
                      decoration:
                          inputDecoration('Nama Belakang', Icons.person)),
                  const SizedBox(height: 8),
                  FormBuilderTextField(
                    name: 'email',
                    decoration: inputDecoration('Email', Icons.email),
                  ),
                  const SizedBox(height: 8),
                  FormBuilderTextField(
                    name: 'password',
                    obscureText: true,
                    decoration: inputDecoration('Password', Icons.lock),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                        child: const Text('Register'),
                        color: Colors.blue,
                        onPressed: () {
                          formKey.currentState!.saveAndValidate();
                          print(formKey.currentState!.value);
                        }),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
