// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onPress;

  MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: const Color.fromARGB(255, 0, 0, 0),
            size: 20,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w300, fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
