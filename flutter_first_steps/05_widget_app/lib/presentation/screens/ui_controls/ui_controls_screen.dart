import 'package:flutter/material.dart';

class UiControlsScreen extends StatelessWidget {
  static const name = 'ui_controls_screen';

  const UiControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ui Controls'),
      ),
      body: const _UiControlsView(),
    );
  }
}

enum Transportation { car, plane, boat, submarine }

class _UiControlsView extends StatefulWidget {
  const _UiControlsView();

  @override
  State<_UiControlsView> createState() => _UiControlsViewState();
}

class _UiControlsViewState extends State<_UiControlsView> {
  bool isDeveloper = true;
  Transportation selectedTransportation = Transportation.car;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        SwitchListTile(
          title: const Text('Developer Mode'),
          subtitle: const Text('Controles adicionales'),
          value: isDeveloper,
          onChanged: (value) => setState(() {
            isDeveloper = !isDeveloper;
          }),
        ),

        ExpansionTile(
          title: const Text('Vehículo de transporte'),
          subtitle: Text('$selectedTransportation'),
        ),

        RadioGroup<Transportation>(
          groupValue: selectedTransportation,
          onChanged: (value) {
            if (value == null) return;

            setState(() {
              selectedTransportation = value;
            });
          },
          child: const Column(
            children: [
              RadioListTile<Transportation>(
                title: Text('By Car'),
                subtitle: Text('Viajar en coche'),
                value: Transportation.car,
              ),
              RadioListTile<Transportation>(
                title: Text('By boat'),
                subtitle: Text('Viajar en barco'),
                value: Transportation.boat,
              ),
              RadioListTile<Transportation>(
                title: Text('By Plane'),
                subtitle: Text('Viajar en avion'),
                value: Transportation.plane,
              ),
              RadioListTile<Transportation>(
                title: Text('By Submarine'),
                subtitle: Text('Viajar en submarino'),
                value: Transportation.submarine,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
