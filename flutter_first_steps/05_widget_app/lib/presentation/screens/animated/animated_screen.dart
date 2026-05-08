import 'package:flutter/material.dart';

class AnimatedScreen extends StatelessWidget {

  static const name = 'animated_screen';

  const AnimatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Container'),
      ),


      body: Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.play_arrow_rounded)
      ),
    );
  }
}