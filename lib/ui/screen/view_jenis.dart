import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kost/common/controllers/kost_controller.dart';
import 'package:kost/ui/widgets/custom_card.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const baseUrl = "http://192.168.88.102/kost";
const apiKey = "691ACB";

class ViewJenis extends StatelessWidget {
  final controller = Get.put(KostController());
  final List<String> satuanHarga = [
    " / hari",
    " / minggu",
    " / bulan",
    " / tahun"
  ];

  // String idJenis;
  // String namaJenis;

  ViewJenis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            foregroundColor: Colors.black54,
            backgroundColor: Colors.white,
            title: Text("Kost " + controller.namaJenis),
            elevation: 0.0,
          ),
          body: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            itemCount: controller.daftarKost.length,
            itemBuilder: (context, index) {
              final kost = controller.daftarKost[index];
              //return Container();
              return CustomCard(
                isShadow: true,
                bgColor: Colors.white,
                shadowOpacity: .5,
                height: 250,
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
                        child: Image.network(
                          "$baseUrl/assets/img/${kost.foto}",
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
            staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
          )),
    );
  }
}
