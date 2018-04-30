import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math' as math;

Future<Null> main() async => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Material(
            color: Colors.black38,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 400.0,
                  maxHeight: constraints.maxHeight,
                ),
                child: ListView.builder(
                  physics: CustomScrollPhysics(),
                  itemExtent: 250.0,
                  itemBuilder: (BuildContext context, int index) => Container(
                        padding: EdgeInsets.symmetric(vertical: 9.0),
                        child: Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(5.0),
                          color:
                              index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
                          child: Center(
                            child: Text(index.toString()),
                          ),
                        ),
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomSimulation extends Simulation {
  final double initPosition;
  final double velocity;

  CustomSimulation({this.initPosition, this.velocity});

  @override
  double x(double time) {
    var max =
        math.max(math.min(initPosition, 0.0), initPosition + velocity * time);

    // print(max.toString());

    return max;
  }

  @override
  double dx(double time) {
    // print(velocity.toString());
    return velocity;
  }

  @override
  bool isDone(double time) {
    return false;
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  @override
  ScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomScrollPhysics();
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    return CustomSimulation(
      initPosition: position.pixels,
      velocity: velocity,
    );
  }
}
