import 'package:flutter/material.dart';


class MenuItems {

  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItems({
    required this.title, 
    required this.subTitle, 
    required this.link, 
    required this.icon,
    });

}

const appMenuItems = <MenuItems>[

  MenuItems(
    title: 'Riverpod Counter',
    subTitle: 'Introduccion a Riverpod',
    link: '/counter-river',
    icon: Icons.add,
  ),

  MenuItems(
    title: 'Botones',
    subTitle: 'Varios botones en Flutter',
    link: '/buttons',
    icon: Icons.smart_button_outlined,
  ),



  MenuItems(
    title: 'Tarjetas',
    subTitle: 'Un contenedor estilizado',
    link: '/cards',
    icon: Icons.credit_card,
  ),

  MenuItems(
    title: 'Progress Indicators',
    subTitle: 'Generales y controlados',
    link: '/progress',
    icon: Icons.refresh_rounded,
  ),

  MenuItems(
    title: 'Snackbars y diálogos',
    subTitle: 'Snackbar y boton flotante',
    link: '/snackbars',
    icon: Icons.info_outline,
  ),

  MenuItems(
    title: 'Animated Container',
    subTitle: 'Stateful widget animado',
    link: '/animated',
    icon: Icons.check_box_outline_blank_rounded,
  ),

  MenuItems(
    title: 'Ui Controls + Tiles',
    subTitle: 'Serie de controles de Flutter',
    link: '/ui-controls',
    icon: Icons.car_rental_outlined,
  ),

  MenuItems(
    title: 'Introcducción a la aplicacción',
    subTitle: 'Pequeño tutorial introductorio',
    link: '/tutorial',
    icon: Icons.accessibility_rounded,
  ),



];




