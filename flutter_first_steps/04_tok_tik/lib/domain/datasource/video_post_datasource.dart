import 'package:tok_tik/domain/entitites/video_post.dart';


abstract class VideoPostDataSource {

  Future<List<VideoPost>> getTrendingvideosByUser(int page);

  Future<List<VideoPost>> getTrendingvideosByPage(int page);
  
}