import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScrollScreen extends StatefulWidget {

  static const name = 'infinite_screen';

  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {

  List<int> imagesIds = [237,219,218,244,200];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Scroll'),
      ),

      body: ListView.builder(
        itemCount: imagesIds.length,
        itemBuilder: (context, index){
          return FadeInImage(
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300,
            placeholder: const AssetImage('assets/images/jar-loading.gif'), 
            image: NetworkImage('https://picsum.photos/id/${ imagesIds[index] }/500/300'),
          );
        }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pop(),
        child: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
    );
  }
}