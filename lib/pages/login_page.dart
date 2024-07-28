import 'package:flutter/material.dart';
import 'package:meowtalk/auth/auth_serviece.dart';
import 'package:meowtalk/components/my_button.dart';
import 'package:meowtalk/components/my_textfield.dart';

class LoginPage extends StatelessWidget{

  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();

  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});
  void login(BuildContext context) async{
    final authService = AuthServiece();
    //longin
    try {
      await authService.signInWithEmailPassword(userEmail.text, userPassword.text);
    }catch (e){
      showDialog(context: context,
          builder: (context) =>AlertDialog(title: Text(e.toString()),));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color(0xff202342),
      body: Container(
        padding: const EdgeInsets.only(top:80,left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/cute_cat.png'),
                width: 250,
                height: 250,
              ),
              const Text("meow,wellcome back!",
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
              const SizedBox(height: 15,),
              MyTextfield(
                hintTxt: "Password",
                hide: true,
                controller: userPassword,
                inSideColor: const Color(0xff242746),

              ),
              const SizedBox(height: 60,),
              MyButton(button: "Login",
                onTap: ()=> login(context),),
              const SizedBox(height: 70,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("havn't an acount? ",
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: 14,
                    ),),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text("Reginter Now!",
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