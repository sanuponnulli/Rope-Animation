// https://github.com/sanuponnulli

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ropeanimation/points.dart';
import 'package:ropeanimation/rope_simulation.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          Offset tapPosition = details.localPosition;
          List<Points> list = Meth.lastparticles;

          if (list.isNotEmpty) {
            for (var particle in list) {
              particle.locked = true;
              particle.updatePosition(tapPosition.dx, tapPosition.dy);
              particle.updateVelocity(0, 0);
            }
          }
        },
        child: Stack(
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              50,
              (index) => ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    child: RopeSimulation(
                      strokewidth: Random().nextInt(3) + 1,
                      x: 10 +
                          index *
                              5, // Adjust spacing as needed (here, + 5 for each)
                      y: 1,
                      spacing: Random().nextInt(30) +
                          2, // Random spacing between 5 and 25
                      noOfParticles: Random().nextInt(30) +
                          10, // Random particles between 10 and 40
                    ),
                  )),
        ),
      ),
    );
  }
}
