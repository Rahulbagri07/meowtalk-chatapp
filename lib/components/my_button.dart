import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{
  final void Function()? onTap;
  final String button;
  const MyButton({super.key, required this.button, this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 50,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Color(0xff40CD80),
        ),
        child: Center(child: Text(button,style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500
        ),),
        )
      ),
    );
  }

}