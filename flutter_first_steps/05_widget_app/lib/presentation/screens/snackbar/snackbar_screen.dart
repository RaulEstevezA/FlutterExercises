import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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


  void openDialog(BuildContext context){

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('¿Estás seguro?'),
        content: Text('Excepteur tempor cillum labore consequat et pariatur ullamco commodo sunt voluptate id pariatur sit. Qui ipsum eu ipsum eu culpa sunt irure labore nulla ipsum laborum. Eu occaecat Lorem magna sint dolore deserunt proident ex commodo commodo.'),
        actions: [
          TextButton(onPressed: ()=> context.pop(), child: const Text('Cancelar')),
          FilledButton(onPressed: ()=>context.pop, child:  Text('Aceptar'))
        ],
      )
      );

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
                    const Text('Adipisicing magna officia ipsum cillum quis qui. Magna dolore aute adipisicing esse irure ipsum nostrud veniam magna tempor. Officia elit exercitation incididunt excepteur in laborum veniam ad.')
                  ]
                );
              }, 
              child: const Text('Licencias usadas')),

            SizedBox(height: 30,),

            FilledButton.tonal(
              onPressed: () => openDialog(context),
              child: const Text('Mostrar dialogo'
              )
            )
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