import 'package:dio/dio.dart' show Dio, Options, Headers;
import 'package:first_flutter_bloc/models/users.dart';
import 'package:first_flutter_bloc/repositories/users/users_repository.dart';
import 'package:first_flutter_bloc/utils/constants.dart';

class UserRepositoryImplement extends UserRepository {
  @override
  Future<List<UserModel>> getAllUsers() async {
    var response = await Dio().get('${Constants.apiUrl}/users', options: Options( headers: {
      Headers.contentTypeHeader: 'application/json',
      Headers.acceptHeader: 'application/json',
      'Authorization': 'Bearer ${Constants.token}'
    }));

    if(response.statusCode != 200) {
      throw Exception(response.statusMessage);
    }
    return ((response.data) as List).map((e) => UserModel.fromJson(e)).toList();
  }
  
}