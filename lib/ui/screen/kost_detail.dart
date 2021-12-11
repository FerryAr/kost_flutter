import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:kost/common/controllers/kost_by_id_controller.dart';
import 'package:kost/common/controllers/kost_detail_controller.dart';
import 'package:kost/ui/widgets/custom_card.dart';
import 'package:url_launcher/url_launcher.dart';

const baseUrl = "http://192.168.218.148/kost";

class KostDetail extends StatelessWidget {
  final kostByIdController = Get.put(KostByIdController());
  //final kostDetailController = KostDetailController();
  KostDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   foregroundColor: Colors.black54,
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        // ),
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 250,
                          child: Image.network(
                            "$baseUrl/assets/img/${kostByIdController.kost.fotoUnggulan}",
                            fit: BoxFit.cover,
                          ),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Kos disewakan oleh " +
                                    kostByIdController.kost.pemilik,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Text(
                                    "Kontak : ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  InkWell(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        kostByIdController.kost.noHp,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    onTap: () => launch(
                                        'https://wa.me/${kostByIdController.kost.noHp.replaceFirst("0", "+62")}'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Divider(
                          thickness: 1.5,
                          color: Colors.black12,
                        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
