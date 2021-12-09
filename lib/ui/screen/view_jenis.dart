import 'package:flutter/material.dart';
import 'package:kost/common/controllers/kost_controller.dart';
import 'package:kost/ui/widgets/custom_card.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const baseUrl = "http://192.168.218.254/kost";
const apiKey = "691ACB";

class ViewJenis extends StatelessWidget {
  final controller = Get.put(KostController());

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
                height: 200,
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
                          "$baseUrl/assets/img/${kost.fotoUnggulan}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.black,
                                size: 18,
                              ),
                              Text(
                                controller.daftarKost[index].alamat,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
