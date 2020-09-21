import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'boxes.dart';
import 'db/colored_path.dart';
import 'path_painter.dart';

class SketchPaint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<ColoredPath>>(
      valueListenable: Boxes.sketchBox.listenable(),
      builder: (_, box, __) {
        var paths = box.values; //.whereType<ColoredPath>();
        return Stack(
          children: [
            for (var path in paths)
              CustomPaint(
                size: Size.infinite,
                painter: PathPainter(path),
              ),
          ],
        );
      },
    );
  }
}
