import 'package:flutter/material.dart';
import 'package:tok_tik/domain/entitites/video_post.dart';
import 'package:tok_tik/presentation/widgets/shared/video_buttons.dart';

class VideoScrollableView extends StatelessWidget {

  final List<VideoPost> videos;

  const VideoScrollableView({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: videos.length,
      itemBuilder: (context, index){
        final VideoPost  videoPost = videos[index];

        return Stack(
          children: [



            Positioned(
              bottom : 40,
              right: 20,
              child: VideoButtons(video: videoPost)),
            //
          ],
        );
      },
    );
  }
}


class _CustomIconButtom extends StatelessWidget {

  final int value;
  final IconData iconData;
  final Color color;



  const _CustomIconButtom({
    required this.value, 
    required this.iconData, 
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}