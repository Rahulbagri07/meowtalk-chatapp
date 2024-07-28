import 'package:flutter/material.dart';
import 'package:meowtalk/components/my_button.dart';
import 'package:meowtalk/components/my_textfield.dart';

import '../auth/auth_serviece.dart';


class RegisterPage extends StatelessWidget{
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();
  final TextEditingController userConfirmPassword = TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});
  void register(BuildContext context){
    final authService = AuthServiece();
    if(userPassword.text==userConfirmPassword.text){
      try {
        authService.signUpWithEmailPassword(
            userEmail.text,
            userPassword.text);}
      catch (e){
        showDialog(context: context,
            builder: (context) =>AlertDialog(title: Text(e.toString()),));
      }
    }else{
      showDialog(context: context,
          builder: (context) =>const AlertDialog(title: Text("password don't match")));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff202342),
      body: Container(
        padding: const EdgeInsets.only(top: 80,left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/cute_cat.png'),
                width: 250,
                height: 250,
              ),
              const Text("meow, wellcome",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15
                ),),
              Row(
                children: [
                  const Text("Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w800

                    ),),
                  Expanded(child: Container())
                ],
              ),
              const SizedBox(height: 10,),
              MyTextfield(
                hintTxt: "Email",
                hide: false,
                controller: userEmail,
                inSideColor: const Color(0xff242746),
              ),
              const SizedBox(height: 10,),
              MyTextfield(
                hintTxt: "Password",
                hide: true,
                controller: userPassword,
                inSideColor: const Color(0xff242746),

              ),
              const SizedBox(height: 10,),
              MyTextfield(
                hintTxt: "Confirm Password",
                hide: true,
                controller: userConfirmPassword,
                inSideColor: const Color(0xff242746),

              ),
              const SizedBox(height: 70,),
              MyButton(button: "Register",
                onTap: ()=>register(context),),
              const SizedBox(height: 80,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("have an account already? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text("Login Now!",
                      style: TextStyle(
                        color: Color(0xff40CD80),
                        fontSize: 14,
                      ),),
                  )
                ],
              )


            ],
          ),
        ),
      ),

    );
  }

}