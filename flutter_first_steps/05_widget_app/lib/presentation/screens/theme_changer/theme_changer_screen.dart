import 'package:flutter/material.dart';

class ThemeChangerScreen extends StatelessWidget {

  static const name = 'theme_changer_screen';
  
  const ThemeChangerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Changer'),
        actions: [
          
        ],
      ),
    );
  }
}