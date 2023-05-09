import 'package:dio/dio.dart';
import 'package:first_flutter_bloc/models/posts.dart';
import 'package:first_flutter_bloc/repositories/posts/posts_repository.dart';
import 'package:first_flutter_bloc/utils/utils.dart';

class PostRepositoryImpl extends PostRepository {
  @override
  Future<List<PostModel>> getAllPostsByUser(int userId) async {
    var response = await Dio().get(
      '${Constants.apiUrl}/users/$userId/posts',
      options: Options(
        headers: {
          Headers.contentTypeHeader: 'apllication/json',
          Headers.acceptHeader: 'application/json',
          'Autorization': "Bearer ${Constants.token}"
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception(response.statusMessage);
    }

    return (response.data as List)
        .map((element) => PostModel.fromJson(element))
        .toList();
  }
}
