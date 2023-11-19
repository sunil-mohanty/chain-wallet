import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String label;
  CircularIconButton(
      {required this.icon, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Center(
            child: Icon(
              icon,
              color: Color.fromARGB(255, 85, 83, 83),
            ),
          ),
        ),
      ),
      SizedBox(height: 8.0),
      Text(label, style: TextStyle(color: Colors.white)),
    ]);
  }
}
