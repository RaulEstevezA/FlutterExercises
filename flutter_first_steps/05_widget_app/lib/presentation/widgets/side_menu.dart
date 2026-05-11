import 'package:flutter/material.dart';
import 'package:widget_app/config/menu/menu_items.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  int navDraweIndex = 0;
  @override
  Widget build(BuildContext context) {

    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;


    return NavigationDrawer(
      selectedIndex: navDraweIndex,
      onDestinationSelected: (valeu){
        setState(() {
          navDraweIndex = valeu;
        });
      },
      children: [
        Padding(
          padding: EdgeInsetsGeometry.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
          child: Text('Menu'),
        ),

        ...appMenuItems.map((item) => NavigationDrawerDestination(
          icon: Icon(item.icon), 
          label: Text(item.title)
          ),
        )
      ]
    );
  }
}