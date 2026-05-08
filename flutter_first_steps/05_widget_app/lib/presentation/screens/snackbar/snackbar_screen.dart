import 'package:flutter/material.dart';
import 'package:widget_app/config/theme/app_theme.dart';

class SnackbarScreen extends StatelessWidget {

  static const name = 'snackbar_screen';

  const SnackbarScreen({super.key});

  void showCustomSnackbar (BuildContext context) {

    ScaffoldMessenger.of(context).clearSnackBars();

    final snackBar = SnackBar(
      content: const Text('Hola Mundo'),
      action: SnackBarAction(label: 'Ok!', onPressed: (){}),
      duration: const Duration(seconds: 2),
      );


    ScaffoldMessenger.of(context).showSnackBar( snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars y Diálogos'),
      ),


      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: (){
                showAboutDialog(
                  context: context,
                  children: [
                    const Text('Laboris eiusmod culpa officia et ex irure minim eu est.')
                  ]
                );
              }, 
              child: const Text('Licencias usadas')),

            FilledButton.tonal(
              onPressed: (){}, 
              child: const Text('Mostrar dialogo'))
          ],
        ),
      ),



      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showCustomSnackbar(context),
        icon: const Icon(Icons.remove_red_eye_outlined),
        label: const Text('Mostrar Snackbar')),
    );
  }
}