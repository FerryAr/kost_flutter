import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kost/common/controllers/kost_by_id_controller.dart';
import 'package:get/get.dart';

const baseUrl = "https://kost.diengcyber.com";

class CarouselFoto extends StatefulWidget {
  const CarouselFoto({Key? key}) : super(key: key);

  @override
  _CarouselFotoState createState() => _CarouselFotoState();
}

class _CarouselFotoState extends State<CarouselFoto> {
  final CarouselController _controller = CarouselController();
  final kostByIdController = Get.put(KostByIdController());
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => kostByIdController.kost.foto.isEmpty
          ? const SizedBox()
          : Column(
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    CarouselSlider.builder(
                      carouselController: _controller,
                      itemCount: kostByIdController.kost.foto.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) =>
                          CachedNetworkImage(
                        imageUrl:
                            "$baseUrl/assets/img/foto_kost/${kostByIdController.kost.foto[itemIndex]}",
                        fit: BoxFit.cover,
                        width: 1280,
                        height: 720,
                      ),
                      options: CarouselOptions(
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
                    Container(
                      width: 40,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      margin: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Center(
                        child: Text(
                          "${(_current + 1).toString()} / ${kostByIdController.kost.foto.length}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
