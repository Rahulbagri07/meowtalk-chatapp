import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, this.onTap});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(vertical:5 ,horizontal: 15),
        decoration: BoxDecoration(
          color: const Color(0xff252431),
          borderRadius: BorderRadius.circular(10)

        ),
        child: Row(
          children: [
            const SizedBox(width: 20,),
            const Icon(Icons.person,color: Colors.white,),
            const SizedBox(width: 20,),
            Text(text,style: const TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}
