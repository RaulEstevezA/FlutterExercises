import 'package:flutter/material.dart';

class SnackbarScreen extends StatelessWidget {

  static const name = 'snackbar_screen';

  const SnackbarScreen({super.key});

  void showCustomSnackbar (BuildContext context) {

    final SnackBar = SnackBar(content: const Text('Hola Mundo'));


    ScaffoldMessenger.of(context).showSnackBar( SnackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars y Diálogos'),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          
          
        },
        icon: const Icon(Icons.remove_red_eye_outlined),
        label: const Text('Mostrar Snackbar')),
    );
  }
}