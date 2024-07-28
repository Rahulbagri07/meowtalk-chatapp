import 'package:flutter/material.dart';
import 'package:meowtalk/auth/auth_serviece.dart';
import 'package:meowtalk/chat/chat_service.dart';
import 'package:meowtalk/components/user_tile.dart';
import 'package:meowtalk/pages/chat_page.dart';
import 'package:meowtalk/pages/settings_page.dart';

class HomePage extends StatelessWidget {


  HomePage({super.key});

  final ChatService chatService = ChatService();
  final AuthServiece authServiece = AuthServiece();



  void settings(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f202b),

      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 30),
            width: MediaQuery.of(context).size.width,
            height: 120,
            decoration: const BoxDecoration(
              color: Color(0xff40CD80),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))
            ),
            child: Row(children: [

              const Text("Massages",style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w800
              ),),
              Expanded(child: Container()),
              IconButton(
                  onPressed: ()=>settings(context),
                  icon: const Icon(Icons.settings,color: Colors.white,))
            ],),
          ),
          buildUserList()
        ],
      ),
    );
  }
  Widget buildUserList(){
    return StreamBuilder(stream: chatService.getUserStream(),
        builder: (context,snapshot){
      if(snapshot.hasError){
        return const Text("Error");
      }
      if(snapshot.connectionState==ConnectionState.waiting){
        return const Text("Loading...");
      }
      return ListView(
        shrinkWrap: true,
        children: snapshot.data!.map<Widget>((userData)=> buildUserListItem(
            userData,context)).toList(),
      );
    });
  }
  Widget buildUserListItem(Map<String,dynamic>userData, BuildContext context){
    if(userData["email"]!= authServiece.getCurruntUsre()!.email){
      return UserTile(
        text: userData["email"],
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(
            receiverEmail: userData["email"],
            receiverID: userData["uid"],
          )
          ));
        },
      );
    }
    else{return Container(
    );
    }
  }
}
