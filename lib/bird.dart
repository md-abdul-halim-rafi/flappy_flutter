import "package:flutter/material.dart";
import "dart:math" as math;

class Bird extends StatelessWidget {
  const Bird({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Transform(
		alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: Image.asset("assets/bird.png"),
      ),
    );
  }
}
