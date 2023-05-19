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
          'Authorization': "Bearer ${Constants.token}"
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

  @override
  Future<bool> savePostByUser(PostModel postModel) async {
    var response = await Dio().post(
      '${Constants.apiUrl}/users/${postModel.userId}/posts',
      data: postModel.toJson(),
      options: Options(
        headers: {
          Headers.contentTypeHeader: 'application/json',
          Headers.acceptHeader: 'application/json',
          'Authorization': "Bearer ${Constants.token}",
        },
      ),
    );

    // Si no es 200 devuelve el error
    if (response.statusCode != 201) {
      throw Exception(response.statusMessage);
    }

    return true;
  }
}
