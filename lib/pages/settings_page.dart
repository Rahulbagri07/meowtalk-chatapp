import 'package:flutter/material.dart';

import '../auth/auth_serviece.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void logout(BuildContext context){
    final auth = AuthServiece();
    auth.signOut();
    Navigator.pop(context);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f202b),
        appBar: AppBar(
          leading: const BackButton(color: Colors.white,),
          title: const Text("Settings",
          style: TextStyle(fontSize: 30, color: Colors.white),),
          backgroundColor: const Color(0xff2b2a3a),
    ),
      body: Container(
        padding: const EdgeInsets.only(left: 20,right: 20,),
        child: Column(
          children: [
            const Image(image: AssetImage('assets/cute_cat.png'),
              width: 250,
              height: 250,
            ),
            GestureDetector(
              onTap: ()=>logout(context),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color:  Color(0xff313240)
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 20,),
                    Icon(Icons.logout_outlined,size: 30,color: Colors.white,),
                    SizedBox(width: 30,),
                    Text("Log Out",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
