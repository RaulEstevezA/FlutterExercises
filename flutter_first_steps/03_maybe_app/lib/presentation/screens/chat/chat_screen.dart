import 'package:flutter/material.dart';
import 'package:maybe_app/domain/entities/message.dart';
import 'package:maybe_app/presentation/providers/chat_provider.dart';
import 'package:maybe_app/presentation/widgets/chat/her_mesaage_bubble.dart';
import 'package:maybe_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:maybe_app/presentation/widgets/shared/message_field_box.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://s.err.ee/photo/crop/2020/01/14/731378h25e8t4.jpg'),
          ),
        ),
        title: Text('Mi amor'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(child: ListView.builder(
              itemCount: chatProvider.messageList.length,
              itemBuilder: (context, index){
                final message = chatProvider.messageList[index];
                return (message.fromWho == FromWho.hers)
                  ? HerMessageBubble( )
                  : MyMessageBubble( message: message );
            })
            ),

            /// Caja de texto
            const MessageFieldBox(),
          ],
        ),
      ),
    );
  }
}