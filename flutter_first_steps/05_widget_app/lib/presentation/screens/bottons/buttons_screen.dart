import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonsScreen extends StatelessWidget {

  static const String name = 'buttons_screen';

  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons Screen'),
      ),
      body: const _ButtonsView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: (){
          context.pop();
        },
        ),
    );
  }
}

class _ButtonsView extends StatelessWidget {
  const _ButtonsView();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Wrap(
          spacing: 40,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            const ElevatedButton(onPressed: null, child: Text('Elevated Disable')),
            const SizedBox(width: double.infinity),
            ElevatedButton(onPressed: (){}, child: const Text('Elevated')),
            
      
            ElevatedButton.icon(
              onPressed: (){}, 
              icon: const Icon(Icons.access_alarm_rounded), 
              label: const Text('Elevated Icon')),

            FilledButton(onPressed: (){}, child: const Text('Filled')),
            FilledButton.icon(
              onPressed: (){},
              icon: const Icon(Icons.accessibility_new),
              label: const Text('Filled Icon')),

            OutlinedButton(onPressed: (){}, child: const Text('Outlined')),
            OutlinedButton.icon(
              onPressed: (){}, 
              icon: const Icon(Icons.access_alarm),
              label: const Text('Outlined Icon')),

            TextButton(onPressed: (){}, child: const Text('Text')),
            TextButton.icon(
              onPressed: (){},
              icon: const Icon(Icons.abc),
              label: const Text('Text Icon')),

            // todo:custom botton
          ],
        ),
      ),
    );
  }
}