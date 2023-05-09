import 'package:first_flutter_bloc/models/posts.dart';

abstract class PostRepository {
  Future<List<PostModel>> getAllPostsByUser(int userId);
}
