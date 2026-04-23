import 'package:flutter/material.dart';
import 'package:tok_tik/domain/entitites/video_post.dart';

class VideoButtons extends StatelessWidget {

  final VideoPost video;

  const VideoButtons({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CustomIconButtom(value: video.likes, iconData: Icons.favorite, iconColor: Colors.red),
      ],
    );
  }
}

class _CustomIconButtom extends StatelessWidget {

  final int value;
  final IconData iconData;
  final Color? color;



  const _CustomIconButtom({
    required this.value, 
    required this.iconData, 
    iconColor
  }): color = iconColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: (){}, 
          icon: Icon(iconData, color: color)),

          Text('$value'),
    ],
    );
  }
}