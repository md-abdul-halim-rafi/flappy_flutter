import 'dart:async';

import 'package:flappy_bird/barrier.dart';
import 'package:flappy_bird/bird.dart';
import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  bool gameHasStarted = false;

  static double barrierXOne = 1;
  double barrierXTwo = barrierXOne + 1.5;

  void _jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  void _startGame() {
    setState(() {
      gameHasStarted = true;
    });

    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;

      height = -4.9 * time * time + 2.8 * time;

      setState(() {
        birdYAxis = initialHeight - height;

        if (barrierXOne < 1.1) {
          barrierXOne += 2.2;
        } else {
          barrierXOne -= 0.05;
        }

        if (barrierXTwo < 1.1) {
          barrierXTwo += 2.2;
        } else {
          barrierXTwo -= 0.05;
        }
      });

      if (birdYAxis > 1) {
        timer.cancel();

        setState(() {
          gameHasStarted = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          _jump();
        } else {
          _startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      alignment: Alignment(0, birdYAxis),
                      color: Colors.blue,
                      child: const Bird()),
                  Container(
                    alignment: const Alignment(0, -0.3),
                    child: Text(gameHasStarted ? "" : "Tap to start"),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barrier(
                      size: 150.0,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
                child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "SCORE",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      Text(
                        "0",
                        style: TextStyle(color: Colors.white, fontSize: 26),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "BEST",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      Text(
                        "10",
                        style: TextStyle(color: Colors.white, fontSize: 26),
                      ),
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
