import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  int navDraweIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: navDraweIndex,
      onDestinationSelected: (valeu){
        setState(() {
          navDraweIndex = valeu;
        });
      },
      children: [
        Padding(
          padding: const EdgeInsetsGeometry.fromLTRB(28, 20, 16, 10),
          child: Text('Menu'),
        ),
        NavigationDrawerDestination(icon: Icon(Icons.abc), label: const Text ('Home Screen')),
        NavigationDrawerDestination(icon: Icon(Icons.ac_unit), label: const Text ('Home Dos'))
      ]
    );
  }
}