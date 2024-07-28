import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meowtalk/auth/auth_serviece.dart';
import 'package:meowtalk/chat/chat_bubble.dart';
import 'package:meowtalk/chat/chat_service.dart';
import 'package:meowtalk/components/my_textfield.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();

  final ChatService chatService = ChatService();
  final AuthServiece authServiece = AuthServiece();

  FocusNode myFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    myFocusNode.addListener((){
      if(myFocusNode.hasFocus){
        Future.delayed(const Duration(milliseconds: 500),() => ScrollDown());
      }
    });

    Future.delayed(const Duration(milliseconds: 500),()=> ScrollDown());
  }


  @override
  void dispose() {
    myFocusNode.dispose();
    messageController.dispose();
    super.dispose();
  }

  ScrollController scrollController = ScrollController();
  void ScrollDown(){
    scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn);
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(widget.receiverID, messageController.text);
      messageController.clear();
      ScrollDown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2F2C40),
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text(
          widget.receiverEmail,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff2F2C40),
      ),
      body: Column(
        children: [
          Expanded(child: buildMessageList()),
          buildUserInput(),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }

  Widget buildMessageList() {
    String senderID = authServiece.getCurruntUsre()!.uid;
    return StreamBuilder(
        stream: chatService.getMessage(widget.receiverID, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..");
          }
          return ListView(
            controller: scrollController,
            children: snapshot.data!.docs
                .map((doc) => buildMessageListItem(doc))
                .toList(),
          );
        });
  }

  Widget buildMessageListItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurruntUser = data["senderEmail"]==authServiece.getCurruntUsre()!.email;

    var alignment = isCurruntUser? Alignment.centerRight:Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurruntUser?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["message"], curruntUser: isCurruntUser)
        ],
      ),
    );
  }

  Widget buildUserInput() {
    return Row(
      children: [
        const SizedBox(width: 10,),
        Expanded(
            child: MyTextfield(
          hide: false,
          hintTxt: "type a message",
          controller: messageController,
              focusNode: myFocusNode,
              inSideColor: const Color(0xff39374C),

        ),
        ),
        IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.arrow_upward,
              color: Color(0xff40CD80),))
      ],
    );
  }
}
