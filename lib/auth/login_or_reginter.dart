import 'package:flutter/material.dart';
import 'package:meowtalk/pages/login_page.dart';
import 'package:meowtalk/pages/register_page.dart';

class LoginOrReginter extends StatefulWidget {
  const LoginOrReginter({super.key});

  @override
  State<LoginOrReginter> createState() => _LoginOrReginterState();
}

class _LoginOrReginterState extends State<LoginOrReginter> {
  bool showLoginPage = true;
  void togglePages(){
    setState(() {
      showLoginPage= !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(onTap: togglePages ,);
    }else{
      return RegisterPage(onTap: togglePages,);
    }
  }
}
