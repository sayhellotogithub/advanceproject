// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/04
// Description: Optimized Ball Game with multiple motion modes
// Fix Your Timestep → https://goo.gle/3XG7Xhu
// Cornering forces → https://goo.gle/3XG7YSA
// Forge2D (box2d port) → https://goo.gle/43CxmMK
// -------------------------------------------------------------------

import 'dart:math';
import 'package:flutter/material.dart';

class BallGamePage extends StatefulWidget {
  const BallGamePage({super.key});

  @override
  State<BallGamePage> createState() => _BallGamePageState();
}

class _BallGamePageState extends State<BallGamePage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late DateTime _lastTime;
  World? world;

  @override
  void initState() {
    super.initState();
    _lastTime = DateTime.now();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      world = World(size, BallMotionMode.linear);
      _lastTime = DateTime.now();

      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      )..repeat();

      _controller.addListener(() {
        final now = DateTime.now();
        final dt = now.difference(_lastTime).inMilliseconds / 1000;
        _lastTime = now;

        setState(() {
          world?.update(dt);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (world != null)
            GestureDetector(
              onTap: () => setState(() => world!.kickRight()),
              child: CustomPaint(
                painter: BallPainter(world!.ball),
                child: Container(),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final mode in BallMotionMode.values)
                    ElevatedButton(
                      onPressed: () => setState(() => world?.setMode(mode)),
                      child: Text(mode.name),
                    ),
                  ElevatedButton(
                    onPressed: () => setState(() => world?.kickRight()),
                    child: const Text("→ インパルス"),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => world?.kickUp()),
                    child: const Text("↑ インパルス"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class BallPainter extends CustomPainter {
  final Ball ball;

  BallPainter(this.ball);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue;
    canvas.drawCircle(Offset(ball.x, ball.y), ball.size / 2, paint);
  }

  @override
  bool shouldRepaint(covariant BallPainter oldDelegate) => true;
}

enum BallMotionMode {
  linear,
  random,
  bounce,
  euler,
  force,
  friction,
  drag
}

class World {
  late Ball ball;
  Size screenSize;
  BallMotionMode mode;

  World(this.screenSize, this.mode) {
    ball = Ball.createInitial(screenSize);
  }

  void update(double dt) {
    switch (mode) {
      case BallMotionMode.linear:
        ball.updateLinear(dt);
        break;
      case BallMotionMode.random:
        ball.updateRandom(dt);
        break;
      case BallMotionMode.bounce:
        ball.updateBounce(dt, screenSize);
        break;
      case BallMotionMode.euler:
        ball.updateEuler(dt, screenSize);
        break;
      case BallMotionMode.force:
        ball.applyForce(10, 0, dt, screenSize);
        break;
      case BallMotionMode.friction:
        ball.applyFriction(dt, screenSize);
        break;
      case BallMotionMode.drag:
        ball.applyDrag(dt, screenSize);
        break;
    }
  }

  void setMode(BallMotionMode newMode) {
    reset();
    mode = newMode;
  }

  void reset() {
    ball = Ball.random(screenSize);
  }

  void kickRight() => ball.applyImpulse(500, 0);

  void kickUp() => ball.applyImpulse(0, -300);
}

class Ball {
  double x;
  double y;
  double vx;
  double vy;
  double ax;
  double ay;
  final double mass;
  double size;
  final double frictionCoef;
  final double dragCoef;
  final Random rand = Random();
  double randomTimer = 0;

  Ball({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    this.ax = 0,
    this.ay = 0,
    this.mass = 1,
    this.size = 40,
    this.frictionCoef = 0.5,
    this.dragCoef = 0.1,
  });

  void applyImpulse(double ix, double iy) {
    vx += ix / mass;
    vy += iy / mass;
  }

  void applyFriction(double dt, Size screenSize) {
    if (vx != 0 || vy != 0) {
      final v = sqrt(vx * vx + vy * vy);
      final fx = -vx / v * frictionCoef * mass;
      final fy = -vy / v * frictionCoef * mass;
      applyForce(fx, fy, dt, screenSize);
    }
  }

  void applyDrag(double dt, Size screenSize) {
    applyForce(-dragCoef * vx, -dragCoef * vy, dt, screenSize);
  }

  void applyForce(double fx, double fy, double dt, Size screenSize) {
    ax += fx / mass;
    ay += fy / mass;
    updateEuler(dt, screenSize);
  }

  void updateLinear(double dt) {
    x += vx * dt;
    y += vy * dt;
  }

  void updateEuler(double dt, Size screenSize) {
    vx += ax * dt;
    vy += ay * dt;
    x += vx * dt;
    y += vy * dt;
    _handleWallBounce(screenSize);
    ax = 0;
    ay = 0;
  }

  void updateRandom(double dt) {
    randomTimer -= dt;
    if (randomTimer <= 0) {
      final angle = rand.nextDouble() * 2 * pi;
      final speed = 100 + rand.nextDouble() * 100;
      vx = cos(angle) * speed;
      vy = sin(angle) * speed;
      randomTimer = 1.0 + rand.nextDouble();
    }
    updateLinear(dt);
  }

  void updateBounce(double dt, Size screenSize) {
    x += vx * dt;
    y += vy * dt;
    _handleWallBounce(screenSize);
  }

  void _handleWallBounce(Size screenSize) {
    if (x - size / 2 <= 0 && vx < 0) {
      x = size / 2;
      vx = -vx;
    } else if (x + size / 2 >= screenSize.width && vx > 0) {
      x = screenSize.width - size / 2;
      vx = -vx;
    }
    if (y - size / 2 <= 0 && vy < 0) {
      y = size / 2;
      vy = -vy;
    } else if (y + size / 2 >= screenSize.height && vy > 0) {
      y = screenSize.height - size / 2;
      vy = -vy;
    }
  }

  static Ball random(Size screenSize) {
    final rand = Random();
    final speed = 100 + rand.nextDouble() * 100;
    final angle = rand.nextDouble() * 2 * pi;
    return Ball(
      x: screenSize.width / 2,
      y: screenSize.height / 2,
      vx: cos(angle) * speed,
      vy: sin(angle) * speed,
    );
  }

  static Ball createInitial(Size screenSize) {
    return Ball(
      x: screenSize.width / 2,
      y: screenSize.height / 2,
      vx: 100,
      vy: 60,
    );
  }
}
