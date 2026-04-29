import 'package:tok_tik/domain/datasource/video_post_datasource.dart';
import 'package:tok_tik/domain/entitites/video_post.dart';
import 'package:tok_tik/infrastructure/models/local_video_model.dart';
import 'package:tok_tik/shared/data/local_video_post.dart';


class LocalVideoDatasource implements VideoPostDataSource {
  @override
  Future<List<VideoPost>> getTrendingvideosByUser(int page) {
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPost>> getTrendingvideosByPage(int page) async {
    await Future.delayed(const Duration(seconds: 2));

    final List<VideoPost> newVideos = videoPosts.map( 
      (video) => LocalVideoModel.fromJson(video).toVideoPostEntity()
      ).toList();
  
    return newVideos;
  }

}