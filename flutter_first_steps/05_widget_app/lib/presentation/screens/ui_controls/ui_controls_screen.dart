import 'package:flutter/material.dart';

class UiControlsScreen extends StatelessWidget {

  static const name = 'ui_controls_screen';

  const UiControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ui Controls'),
      ),
      body: const _UiControlsView(),

    );
  }
}

class _UiControlsView extends StatelessWidget {
  const _UiControlsView();

  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}