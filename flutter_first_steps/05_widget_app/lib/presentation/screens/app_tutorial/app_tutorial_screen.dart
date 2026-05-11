import 'package:flutter/material.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo(this.title, this.caption, this.imageUrl);
}

final slides = <SlideInfo>[
  SlideInfo('Busca la comida', 'Laboris esse dolore nostrud ex Lorem deserunt eu. Dolor elit aliqua dolor velit ea est velit sit culpa ipsum quis aliqua. Nisi labore mollit fugiat ut dolor et veniam velit laborum proident deserunt ad ex incididunt. Quis nostrud ullamco consectetur enim do ad fugiat cillum ullamco culpa qui ipsum veniam. Sint laborum cillum veniam occaecat aliqua sit pariatur id laborum. Sunt esse ipsum elit reprehenderit consequat id cillum. Tempor fugiat cupidatat est nisi et enim cupidatat qui.', 'assets/images/1.png'),
  SlideInfo('Entrega rápida', 'Consectetur voluptate eiusmod aliqua cillum ullamco ipsum ut mollit velit. Eu esse nulla ad exercitation. Id irure aliqua aliquip Lorem irure esse dolore dolore fugiat. Anim exercitation ullamco aliqua adipisicing aliqua incididunt id elit id sunt aliqua magna aute. Laborum esse laborum dolor voluptate incididunt do magna deserunt elit.', 'assets/images/2.png'),
  SlideInfo('Disfruta la comida', 'Consequat minim excepteur eiusmod magna incididunt pariatur culpa laboris est veniam consequat sunt est. Cillum minim anim laboris proident dolore in occaecat irure voluptate quis aute incididunt voluptate. Cillum duis amet cupidatat ex nulla anim aute ullamco amet. Aute ipsum enim sit adipisicing qui aliqua enim ipsum eiusmod.', 'assets/images/3.png'),
];



class AppTutorialScreen extends StatelessWidget {

  static const name = 'tutorial_screen';

  const AppTutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageView(
        physics: const BouncingScrollPhysics(),
        children: slides.map(
          (slideData) => _Slide(
            title: slideData.title,
            caption: slideData.caption,
            imageUrl: slideData.imageUrl,
          )).toList()
        ),
    );
  }
}


class _Slide extends StatelessWidget {

  final String title;
  final String caption;
  final String imageUrl;

  const _Slide({required this.title, required this.caption, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}