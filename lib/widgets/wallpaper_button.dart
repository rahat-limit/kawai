import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WallPaperButton extends StatelessWidget {
  final VoidCallback callback;
  final IconData icon;
  Color color;

  WallPaperButton(
      {super.key,
      required this.callback,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(15)),
        onPressed: () => callback(),
        child: Icon(
          icon,
          size: 26,
          color: color,
        ));
  }
}
