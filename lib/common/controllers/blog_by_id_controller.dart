import 'package:get/get.dart';
import 'package:kost/model/blog_by_id_model.dart';

class BlogByIdController extends GetxController {
  final _blog = Blog().obs;
  final _idBlog = ''.obs;

  //getter
  Blog get getBlog => _blog.value;
  String get getIdBlog => _idBlog.value;

  //setter
  set setBlog(Blog value) => _blog.value = value;
  set setIdBlog(String value) => _idBlog.value = value;

  @override
  void onInit() {
    super.onInit();
  }
}
