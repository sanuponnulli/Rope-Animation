import 'package:ropeanimation/points.dart';
import 'package:vector_math/vector_math_64.dart';

class Spring {
  double k;
  double restLength;
  Points a;
  Points b;

  Spring(
    this.k,
    this.restLength,
    this.a,
    this.b,
  );

  void update() {
    Vector2 force = b.position - a.position;
    double x = force.length - restLength;
    force.normalize();
    force *= k * x / 2;
    a.applyForce(force);
    force *= -1;
    b.applyForce(force);
  }
}
