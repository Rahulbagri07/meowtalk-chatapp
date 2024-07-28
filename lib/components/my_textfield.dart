import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget{
  final String hintTxt;
  final Color inSideColor;
  final bool hide;
  final TextEditingController controller;
  final FocusNode? focusNode;
  const MyTextfield({super.key, required this.hintTxt, required this.hide, required this.controller, required this.inSideColor, this.focusNode});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      focusNode: focusNode,
      controller: controller,
      style: const TextStyle(color: Color(0xff40CD80)),
      obscureText: hide,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color:Colors.white10)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color:Color(0xff40CD80))
        ),
        fillColor: inSideColor,
        filled: true,
        hintText: hintTxt,
        hintStyle: const TextStyle(color: Color(0xff57586e))
      ),
    );
  }


}