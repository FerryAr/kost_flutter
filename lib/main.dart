import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kost/ui/screen/blog_detail.dart';
import 'package:kost/ui/screen/home.dart';
import 'package:kost/ui/screen/kost_detail.dart';
import 'package:kost/ui/screen/profil.dart';
import 'package:kost/ui/screen/search_view.dart';
import 'package:kost/ui/screen/view_jenis.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      supportedLocales: const [
        Locale('id'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
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
        GetPage(name: '/searchview', page: () => const SearchView()),
        GetPage(name: '/profil', page: () => const ProfilScreen()),
        GetPage(name: '/blogdetail', page: () => const BlogDetail()),
      ],
    );
  }
}
