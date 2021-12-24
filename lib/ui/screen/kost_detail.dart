import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kost/common/controllers/kost_by_id_controller.dart';
import 'package:kost/common/controllers/kost_fasilitas_controller.dart';
import 'package:kost/ui/widgets/carousel_kost_foto.dart';
import 'package:kost/ui/widgets/custom_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

const baseUrl = "http://192.168.19.82/kost";

class KostDetail extends StatelessWidget {
  final kostByIdController = Get.put(KostByIdController());
  final fasilitasController = Get.put(KostFasilitasController());
  KostDetail({Key? key}) : super(key: key);

  final List<String> satuanHarga = [
    " / hari",
    " / minggu",
    " / bulan",
    " / tahun"
  ];

  String diffOnline(int timestamp) {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var diffDays = diff.inDays;
    var diffHours = diff.inHours;
    var diffMinutes = diff.inMinutes;
    var diffSeconds = diff.inSeconds;
    if (diffDays > 0) {
      return "$diffDays hari yang lalu";
    } else if (diffHours > 0) {
      return "$diffHours jam yang lalu";
    } else if (diffMinutes > 0) {
      return "$diffMinutes menit yang lalu";
    } else if (diffSeconds > 0) {
      return "$diffSeconds detik yang lalu";
    } else {
      return "Baru saja";
    }
  }

  Widget hargaBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
      ),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (kostByIdController.kost.jenisId.isNotEmpty) ...[
                Text(
                  NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0)
                          .format(int.parse(kostByIdController.kost.harga)) +
                      " " +
                      satuanHarga[
                          int.parse(kostByIdController.kost.jenisId) - 1],
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ],
            ],
          ),
          const InkWell(
            child: CustomCard(
              width: 100,
              height: 35,
              bgColor: Colors.green,
              borderRadius: BorderRadius.zero,
              isShadow: false,
              child: Center(
                child: Text(
                  "Ajukan Sewa",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        bottomSheet: hargaBox(),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 250,
                      child: CarouselFoto(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, left: 10),
                      child: Text(
                        "Kost " + kostByIdController.kost.namaKost,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 15, left: 10),
                          //padding: const EdgeInsets.all(10),
                          height: 25,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black12),
                            //color: Colors.black,
                          ),
                          child: Center(
                            child: Text(
                              "Kos " + kostByIdController.kost.type,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          //padding: const EdgeInsets.all(10),
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              kostByIdController.kost.alamat,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const DottedLine(
                      dashColor: Colors.black38,
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Kos disewakan oleh " +
                                    kostByIdController.kost.dataOperator,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              kostByIdController
                                      .kost.operatorLoginStatus.isEmpty
                                  ? Container()
                                  : kostByIdController
                                              .kost.operatorLoginStatus ==
                                          '1'
                                      ? Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 8),
                                              width: 8,
                                              height: 8,
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const Text(
                                              "Sedang Online",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        )
                                      : kostByIdController
                                              .kost.operatorLastLogout.isEmpty
                                          ? Container()
                                          : Text(
                                              "Aktif " +
                                                  diffOnline(int.parse(
                                                      kostByIdController.kost
                                                          .operatorLastLogout)),
                                            ),
                            ],
                          ),
                          kostByIdController.kost.operatorAvatar.isEmpty
                              ? Container()
                              : CachedNetworkImage(
                                  imageUrl:
                                      "$baseUrl/assets/img/avatars/${kostByIdController.kost.operatorAvatar}",
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                  fit: BoxFit.cover),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      thickness: 1.5,
                      color: Colors.black12,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Fasilitas",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: fasilitasController.fasilitas.fasilitas.length,
                      itemBuilder: (context, index) {
                        final icon = fasilitasController.fasilitas.icon[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      MdiIcons.fromString(icon),
                                    ),
                                  ),
                                  Text(
                                    fasilitasController
                                        .fasilitas.fasilitas[index],
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 75),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.home_outlined),
                    color: Colors.white,
                    onPressed: () => Get.offAllNamed('/'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
