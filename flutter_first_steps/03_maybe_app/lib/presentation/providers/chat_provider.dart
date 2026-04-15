import 'package:flutter/material.dart';
import 'package:maybe_app/domain/entities/message.dart';


class ChatProvider extends ChangeNotifier {

  List<Message> messageList = [
  ];


  Future<void> sendMessage( String text ) async {
    
    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);

    notifyListeners();
  }
}