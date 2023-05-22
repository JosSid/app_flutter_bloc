import 'package:dio/dio.dart' show Dio, Options, Headers;
import 'package:first_flutter_bloc/models/users.dart';
import 'package:first_flutter_bloc/repositories/users/users_repository.dart';
import 'package:first_flutter_bloc/utils/utils.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<List<UserModel>> getAllUsers() async {
    var response = await Dio().get(
      '${Constants.apiUrl}/users',
      options: Options(
        headers: {
          Headers.contentTypeHeader: 'application/json',
          Headers.acceptHeader: 'application/json',
          'Authorization': 'Bearer ${Constants.token}'
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception(response.statusMessage);
    }

    return ((response.data) as List)
        .map((element) => UserModel.fromJson(element))
        .toList();
  }

  @override
  Future<bool> saveUser(UserModel userModel) async {
    var response = await Dio().post(
      '${Constants.apiUrl}/users',
      data: userModel.toJson(),
      options: Options(
        headers: {
          Headers.contentTypeHeader: 'application/json',
          Headers.acceptHeader: 'application/json',
          'Authorization': 'Bearer ${Constants.token}'
        },
      ),
    );

    if (response.statusCode != 201) {
      throw Exception(response.statusMessage);
    }

    return true;
  }

  @override
  Future<bool> removeUser(int userId) async {
    var response = await Dio().delete(
      '${Constants.apiUrl}/users/$userId',
      options: Options(
        headers: {
          Headers.contentTypeHeader: 'application/json',
          Headers.acceptHeader: 'application/json',
          'Authorization': 'Bearer ${Constants.token}'
        },
      ),
    );

    if (response.statusCode != 204) {
      throw Exception(response.statusMessage);
    }

    return true;
  }
}
