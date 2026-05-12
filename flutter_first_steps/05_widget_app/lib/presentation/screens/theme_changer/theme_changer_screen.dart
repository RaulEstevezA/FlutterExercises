import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_app/presentation/providers/theme_provider.dart';

class ThemeChangerScreen extends ConsumerWidget {

  static const name = 'theme_changer_screen';
  
  const ThemeChangerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isDark = ref.watch(isDarkMode);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Changer'),
        actions: [
          IconButton(
            onPressed: (){
              ref.read(isDarkMode.notifier).update((state) => !state);
            }, 
            icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
          )
        ],
      ),
    );
  }
}