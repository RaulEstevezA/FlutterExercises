import 'package:flutter/material.dart';
import 'package:maybe_app/domain/entities/message.dart';


class ChatProvider extends ChangeNotifier {

  List<Message> message = [
    Message (text: 'Hola amor!', fromWho: FromWho.me),
    Message (text: 'Ya regresaste del trabajo?', fromWho: FromWho.me),
  ];


  Future<void> sendMessage( String text ) async {
    // todo
  }
}