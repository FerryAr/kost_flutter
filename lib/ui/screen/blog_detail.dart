import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kost/common/controllers/blog_by_id_controller.dart';

class BlogDetail extends StatelessWidget {
  BlogDetail({Key? key}) : super(key: key);

  final blogByIdController = Get.put(BlogByIdController());
  epochToDate(String epoch) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(epoch) * 1000);
    var d24 = DateFormat('dd/MM/yyyy, HH:mm').format(date);

    return d24;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.black,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    // IconButton(
                    //   icon: const Icon(Icons.home_outlined),
                    //   color: Colors.black,
                    //   onPressed: () => Get.offAllNamed('/'),
                    // ),
                  ],
                ),
                Center(
                  child: Text(
                    blogByIdController.getBlog.judul,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      blogByIdController.getBlog.dibuatPada.isEmpty
                          ? '-'
                          : "Dibuat pada " +
                              epochToDate(
                                  blogByIdController.getBlog.dibuatPada),
                      style: const TextStyle(
                        fontSize: 15,
                        //fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Html(
                  data: blogByIdController.getBlog.isi,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
