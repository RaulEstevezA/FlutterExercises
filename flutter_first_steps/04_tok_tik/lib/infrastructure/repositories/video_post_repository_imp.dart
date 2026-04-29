import 'package:tok_tik/domain/datasource/video_post_datasource.dart';
import 'package:tok_tik/domain/entitites/video_post.dart';
import 'package:tok_tik/domain/repositories/video_post_repository.dart';


class VideoPostsRepositoryImpl implements VideoPostRepository {

  final VideoPostDataSource videosPostDatasource;

  VideoPostsRepositoryImpl({required this.videosPostDatasource});

  @override
  Future<List<VideoPost>> getTrendingvideosByPage(int page) {
    return videosPostDatasource.getTrendingvideosByPage(page);
  }

  @override
  Future<List<VideoPost>> getTrendingvideosByUser(int page) {
    throw UnimplementedError();
  }

}
