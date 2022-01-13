import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kost/common/controllers/blog_controller.dart';
import 'package:kost/common/controllers/kost_terbaru_controller.dart';
import 'package:kost/common/controllers/slider_iklan_controller.dart';
import 'package:kost/common/helper/get_storage_helper.dart';
import 'package:kost/model/data_jenis_kost.dart';
import 'package:kost/ui/widgets/custom_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';

const baseUrl = "https://kost.diengcyber.com";
const apiKey = "691ACB";

Future<DataJenisKost> fetchDataJenis() async {
  final response = await http
      .post(Uri.parse("$baseUrl/api/get_jenis"), body: {'apiKey': apiKey});

  if (response.statusCode == 200) {
    return DataJenisKost.fromJson(json.decode(response.body));
  } else {
    throw Exception('an error occured');
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<DataJenisKost> futureDataJenis;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    setState(() {});
    futureDataJenis = fetchDataJenis();
  }

  final List<String> satuanHarga = [
    " / hari",
    " / minggu",
    " / bulan",
    " / tahun"
  ];

  Widget carouselIklan() {
    final sliderController = Get.put(SliderController());
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sliderController.slider.fotoIklan.isEmpty
              ? Container()
              : CarouselSlider.builder(
                  carouselController: CarouselController(),
                  itemCount: sliderController.slider.fotoIklan.length,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.5),
                          blurRadius: 3.5,
                        ),
                      ],
                    ),
                    child: CachedNetworkImage(
                      imageUrl: baseUrl +
                          "/assets/img/sliders/" +
                          sliderController.slider.fotoIklan[itemIndex],
                      fit: BoxFit.fill,
                      width: 1000,
                    ),
                  ),
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    viewportFraction: 0.9,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: sliderController.slider.fotoIklan.map((url) {
              int index = sliderController.slider.fotoIklan.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.green : Colors.grey,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget qr() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: BoxDecoration(
        //color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          //const SizedBox(width: 20),
          Text(
            'Scan QR dan langsung bayar di tempat',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          Icon(
            Icons.qr_code_scanner,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Widget categoryCard() {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 120,
      child: FutureBuilder<DataJenisKost>(
        future: futureDataJenis,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              primary: false,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.data.length,
              itemBuilder: (context, index) {
                return CustomCard(
                  isShadow: true,
                  bgColor: Colors.white,
                  shadowOpacity: .5,
                  width: 120,
                  margin: const EdgeInsets.only(right: 10),
                  onTap: () => Get.toNamed('/viewjenis', arguments: {
                    'idJenis': snapshot.data!.data[index].id,
                    'namaJenis': snapshot.data!.data[index].jenis,
                  }),
                  shadowBlur: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://images.unsplash.com/photo-1470075801209-17f9ec0cada6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Kost " + snapshot.data!.data[index].jenis,
                            style: const TextStyle(),
                            textAlign: TextAlign.start,
                          )),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            Fluttertoast.showToast(
              msg: snapshot.error.toString(),
              toastLength: Toast.LENGTH_SHORT,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget searchBox() {
    return InkWell(
      onTap: () => Get.toNamed('/searchview'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 20),
            Text(
              'Cari Kost di sini',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Kost",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green[500],
          ),
        ),
        const Spacer(),
        GetStorageBox().box.read('isLoggedIn') == null
            ? InkWell(
                onTap: () {
                  Get.toNamed('/profil');
                },
                child: Container(
                  width: 35.0,
                  height: 35.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/img/blank-avatar.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  Get.toNamed('/profil');
                },
                child: CachedNetworkImage(
                    imageUrl:
                        "$baseUrl/assets/img/avatars/${GetStorageBox().box.read('userAvatar')}",
                    imageBuilder: (context, imageProvider) => Container(
                          width: 35.0,
                          height: 35.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                    fit: BoxFit.cover),
              ),
      ],
    );
  }

  Widget blog() {
    final blogController = Get.put(BlogController());
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      primary: false,
      crossAxisCount: 3,
      itemCount: blogController.getDaftarBlog.length,
      itemBuilder: (context, index) {
        final blog = blogController.getDaftarBlog[index];
        return CustomCard(
          isShadow: true,
          bgColor: Colors.white,
          shadowOpacity: .5,
          //width: double.infinity,
          height: 250,
          margin: const EdgeInsets.only(right: 10),
          shadowBlur: 10,
          //onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl:
                        "$baseUrl/assets/img/blog_thumb/${blog.thumbnail}",
                    fit: BoxFit.fill,
                    //width: double.infinity,
                    height: 150,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    blog.judul,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 7, bottom: 5),
                //padding: const EdgeInsets.all(10),
                height: 25,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black12),
                  //color: Colors.black,
                ),
                child: Center(
                  child: Text(
                    blog.kategori,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  strutStyle: const StrutStyle(
                    fontSize: 12,
                  ),
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    text: parse(blog.isi).documentElement!.text,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5, right: 5),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed('/blogdetail', arguments: {
                        'idBlog': blog.id,
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green[500],
                      ),
                      child: const Text(
                        'Selengkapnya',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Text(
              //   ,
              // )
            ],
          ),
        );
      },
      staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
    );
  }

  Widget kostTerbaru() {
    final kostTerbaruController = Get.put(KostTerbaruController());
    return SizedBox(
      width: 200,
      height: 300,
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: kostTerbaruController.getKostTerbaru.length,
        itemBuilder: (context, index) {
          final kost = kostTerbaruController.getKostTerbaru[index];
          return CustomCard(
            isShadow: true,
            bgColor: Colors.white,
            shadowOpacity: .5,
            width: 120,
            margin: const EdgeInsets.all(15),
            onTap: () {
              Get.toNamed("/kostbyid", arguments: {
                'idKost': kost.idKost,
                //'namaKost': kost.namaKost,
              });
            },
            shadowBlur: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "$baseUrl/assets/img/foto_kost/${kost.foto}",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 3, bottom: 5),
                        //padding: const EdgeInsets.all(10),
                        height: 25,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12),
                          //color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            "Kos " + kost.type,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 3),
                        child: Text(
                          "Kost " + kost.namaKost,
                          style: const TextStyle(
                            fontSize: 15,
                            //fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.black,
                              size: 18,
                            ),
                            Text(
                              kost.alamat,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 6),
                        child: Text(
                          NumberFormat.simpleCurrency(
                                      locale: 'id_ID', decimalDigits: 0)
                                  .format(int.parse(kost.harga)) +
                              " " +
                              satuanHarga[int.parse(kost.jenisId) - 1],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: tabBar(),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                primary: true,
                physics: const AlwaysScrollableScrollPhysics(),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  primary: false,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  children: [
                    const SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 25),
                        carouselIklan(),
                        const SizedBox(height: 25),
                        const Text(
                          "Hai, ",
                          style: TextStyle(
                            fontSize: 15,
                            //fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "Lagi Cari Apa?",
                          style: TextStyle(
                            fontSize: 20,
                            //fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 15),
                        categoryCard(),
                        const SizedBox(height: 20),
                      ],
                    ),
                    Text(
                      'Kost Terbaru',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[500],
                        //fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    kostTerbaru(),
                    const SizedBox(height: 10),
                    Text(
                      'Blog',
                      style: TextStyle(
                        fontSize: 20,
                        //fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    blog(),
                  ],
                ),
              ),
              Positioned(
                top: 1,
                left: 10,
                right: 10,
                child: searchBox(),
              )
            ],
          ),
        ));
  }
}
