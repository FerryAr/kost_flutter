import 'package:get/get.dart';
import 'package:kost/model/blog_model.dart';

const baseUrl = 'https://kost.diengcyber.com';
const apiKey = '691ACB';

class BlogService extends GetConnect {
  Future<BlogModel> fetchAllBlog() async {
    final response =
        await post('$baseUrl/api/get_all_blog', FormData({'apiKey': apiKey}));
    if (response.statusCode == 200) {
      return BlogModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
