import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ColoredPath {
  static List<Paint> _paints;

  static List<Color> get colors => _colors;

  Paint get paint {
    _paints ??= _getPaints();
    return _paints[colorIndex];
  }

  final int colorIndex;

  final path = Path();

  List<Offset> points = [];

  ColoredPath(this.colorIndex);

  void addPoint(Offset point) {
    if (points.isEmpty) {
      path.moveTo(point.dx, point.dy);
    } else {
      path.lineTo(point.dx, point.dy);
    }
    points.add(point);
  }
}

const _colors = <Color>[
  Colors.black,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.amber,
];

List<Paint> _getPaints() {
  return [
    for (var color in _colors)
      Paint()
        ..strokeCap = StrokeCap.round
        ..isAntiAlias = true
        ..color = color
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke,
  ];
}
