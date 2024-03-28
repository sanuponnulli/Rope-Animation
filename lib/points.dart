import 'package:vector_math/vector_math_64.dart';

class Points {
  late Vector2 acceleration;
  late Vector2 velocity;
  late Vector2 position;
  late double mass;
  late bool locked;

  Points(double x, double y) {
    acceleration = Vector2(0, 0);
    velocity = Vector2(0, 0);
    position = Vector2(x, y);
    mass = 1;
    locked = false;
  }

  void updatePosition(x, y) {
    position = Vector2(x, y);
  }

  void updateVelocity(x, y) {
    velocity = Vector2(0, 0);
  }

  // This method applies a force to the particle.
  // It divides the force by the mass of the particle to get the acceleration.
  // It then adds the acceleration to the particle's acceleration.

  void applyForce(Vector2 force) {
    Vector2 f = force;
    f /= mass;
    acceleration += f / 6;
  }

  // This method updates the particle's velocity and position.
  // It multiplies the velocity by 0.99 to simulate friction.
  // It then adds the acceleration to the velocity.
  // It then adds the velocity to the position.
  // It then resets the acceleration to 0.
  void update() {
    if (locked) return;
    velocity *= 0.99;
    velocity += acceleration;
    position += velocity;
    acceleration *= 0;
  }

  @override
  String toString() {
    return 'Particle{, acceleration: $acceleration, velocity: $velocity, position: $position, mass: $mass}';
  }
}
