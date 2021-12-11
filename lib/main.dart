import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kost/ui/screen/home.dart';
import 'package:kost/ui/screen/kost_detail.dart';
import 'package:kost/ui/screen/view_jenis.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Kost',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const Home(),
      getPages: [
        GetPage(name: '/', page: () => const Home()),
        GetPage(name: '/viewjenis', page: () => ViewJenis()),
        GetPage(name: '/kostbyid', page: () => KostDetail()),
      ],
    );
  }
}
