import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kost/common/controllers/slider_iklan_controller.dart';
import 'package:kost/common/helper/get_storage_helper.dart';
import 'package:kost/model/data_jenis_kost.dart';
import 'package:kost/ui/widgets/custom_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

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
    futureDataJenis = fetchDataJenis();
  }

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

  //void _passDataJenis(BuildContext context, String idJenis, String namaJenis) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ViewJenis(
  //           // idJenis: idJenis,
  //           // namaJenis: namaJenis,
  //           ),
  //     ),
  //   );
  // }

  Widget categoryCard() {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 120,
      child: FutureBuilder<DataJenisKost>(
        future: futureDataJenis,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.data.length,
              itemBuilder: (context, index) {
                return CustomCard(
                  isShadow: true,
                  bgColor: Colors.white,
                  shadowOpacity: .5,
                  width: 120,
                  margin: const EdgeInsets.only(right: 10),
                  // onTap: () {
                  //   _passDataJenis(context, snapshot.data!.data[index].id,
                  //       snapshot.data!.data[index].jenis);
                  // },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: tabBar(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ListView(
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
                    qr(),
                    // const SizedBox(height: 25),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10),
                    //   height: 150,
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(color: Colors.black12),
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: const [
                    //       SizedBox(height: 15),
                    //       Center(
                    //         child: Text(
                    //           "Jadi Lebih Tangguh Saat Cari Kos",
                    //           style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(height: 5),
                    //       Text(
                    //         '#TangguhBersama pilih kos terbaik hanya di Mamikos',
                    //         style: TextStyle(
                    //           fontSize: 16,
                    //           color: Colors.black87,
                    //           //fontWeight: FontWeight.w100,
                    //         ),
                    //         //overflow: TextOverflow.ellipsis,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
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
    );
  }
}
