import 'package:tok_tik/domain/datasource/video_post_datasource.dart';
import 'package:tok_tik/domain/entitites/video_post.dart';
import 'package:tok_tik/domain/repositories/video_post_repository.dart';


class VideoPostsRepository implements VideoPostRepository {

  final VideoPostDataSource videoPostDatasource;

  VideoPostsRepository({required this.videoPostDatasource});

  @override
  Future<List<VideoPost>> getTrendingvideosByPage(int page) {
    return videoPostDatasource.getTrendingvideosByPage(page);
  }

  @override
  Future<List<VideoPost>> getTrendingvideosByUser(int page) {
    throw UnimplementedError();
  }

}
