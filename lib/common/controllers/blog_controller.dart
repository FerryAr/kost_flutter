import 'package:get/get.dart';
import 'package:kost/common/services/blog_service.dart';
import 'package:kost/model/blog_model.dart';

class BlogController extends GetxController {
  final _daftarBlog = <BlogData>[].obs;

  //getter
  List<BlogData> get getDaftarBlog => _daftarBlog.toList();

  //setter
  set setDaftarBlog(List<BlogData> value) {
    _daftarBlog.assignAll(value);
  }

  @override
  void onInit() {
    super.onInit();
    getBlog();
  }

  void getBlog() async {
    setDaftarBlog = (await BlogService().fetchAllBlog()).data;

    if (_daftarBlog.isEmpty) {
      Get.snackbar('Info', 'Tidak ada blog',
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.FLOATING,
          duration: const Duration(seconds: 2));
    }
  }
}
