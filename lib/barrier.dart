import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {

  final double size;
  const Barrier({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      color: Colors.red,
    );
  }
}
