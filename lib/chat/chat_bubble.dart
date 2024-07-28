import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {

  final String message;
  final bool curruntUser;
  const ChatBubble({super.key, required this.message, required this.curruntUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 15,vertical:2 ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: curruntUser? const Color(0xff40CD80): const Color(0xff464456)
      ),
      child: Text(message,style: const TextStyle(color: Colors.white),),
    );
  }
}
