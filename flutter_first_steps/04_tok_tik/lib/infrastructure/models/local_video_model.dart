
import 'package:tok_tik/domain/entitites/video_post.dart';

class LocalVideoModel {
  final String name;
  final String videoUrl;
  final int likes;
  final int views;


  LocalVideoModel({
    required this.name,
    required this.videoUrl,
    this.likes = 0,
    this.views = 0,
  });

  factory LocalVideoModel.fromJson(Map<String, dynamic> json) => LocalVideoModel(
    name: json['name'] ?? 'No name', 
    videoUrl: json['videoUrl'],
    views: json['views'] ?? 0,
    likes: json['likes'] ?? 0,
    );


  // 'name': 'Subiendo escaleras automáticas',
  //   'videoUrl': 'assets/videos/1.mp4',
  //   'likes': 23230,
  //   'views': 1523,

  VideoPost toVideoPostEntity() => VideoPost(
    caption: name, 
    videoUrl: videoUrl,
    likes: likes,
    views: views,
    );
}




// toVideoPostEntity;