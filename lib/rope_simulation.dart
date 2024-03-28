import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ropeanimation/rope_painter.dart';

import 'package:vector_math/vector_math_64.dart' as v;

import 'points.dart';
import 'spring.dart';

class RopeSimulation extends StatefulWidget {
  final double x;
  final double y;
  final double spacing;
  final int noOfParticles;
  final double strokewidth;
  const RopeSimulation(
      {super.key,
      required this.x,
      required this.y,
      spa,
      this.spacing = 20,
      this.noOfParticles = 10,
      this.strokewidth = .2});

  @override
  State<RopeSimulation> createState() => _StringSimulationWidgetState();
}

class _StringSimulationWidgetState extends State<RopeSimulation> {
  late v.Vector2 gravity;

  late List<Points> particles;
  late List<Spring> springs;
  late double spacing;
  double k = 0.5;
  late Timer timer;
  late int noOfParticles;

  @override
  void initState() {
    gravity = v.Vector2(0, 0.1);
    spacing = widget.spacing;
    noOfParticles = widget.noOfParticles;
    setUpParticlesAndSpring();
    super.initState();
    update();
  }

  //setting up the particles and springs
  void setUpParticlesAndSpring() {
    Meth.setUpParticlesAndSpring(
        x: widget.x,
        y: widget.y,
        spacing: spacing,
        noOfParticles: noOfParticles);

    particles = Meth.particles;
    springs = Meth.springs;
  }

  update() {
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      for (var spring in springs) {
        spring.update();
      }

      for (var particle in particles) {
        particle.applyForce(gravity);
        particle.update();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RopePainter(particles, springs, widget.strokewidth),
      child: Container(),
    );
  }
}

class Meth {
  static List<Points> particles = [];
  static List<Spring> springs = [];

  static const double k = 0.5;
  late Timer timer;
  static List<Points> lastparticles = [];

  static void setUpParticlesAndSpring({
    required double x,
    required double y,
    required double spacing,
    required int noOfParticles,
  }) {
    particles = List<Points>.filled(noOfParticles, Points(0, 0));
    springs = List<Spring>.filled(
      noOfParticles,
      Spring(0, 0, particles[0], particles[0]),
    );

    for (int i = 0; i < noOfParticles; i++) {
      particles[i] = Points(x + i * spacing, y + i * spacing);
      if (i != 0) {
        var a = particles[i];
        var b = particles[i - 1];
        var spring = Spring(k, spacing, a, b);
        springs[i] = spring;
      }
    }

    particles[0].locked = true;

    particles.last.locked = false;

    lastparticles.add(particles.last);
  }
}
